import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:iron_byte/core/constants/app_constants.dart';
import 'package:iron_byte/core/utils/consultation_schedule.dart';
import 'package:iron_byte/features/home/data/consultation_api_exception.dart';
import 'package:iron_byte/features/home/data/consultation_feature_log.dart';
import 'package:iron_byte/features/home/data/consultation_http_client.dart';
import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';

/// HTTP client for Iron Byte consultation booking endpoints.
class ConsultationRemoteDataSource {
  ConsultationRemoteDataSource({
    http.Client? client,
    String? baseUrl,
    Duration timeout = const Duration(seconds: 30),
  }) : _client = client ?? createConsultationHttpClient(),
       _baseUrl = baseUrl ?? AppConstants.apiBaseUrl,
       _timeout = timeout {
    ConsultationFeatureLog.d(
      'ConsultationRemoteDataSource initialized '
      '(baseUrl=$_baseUrl, kIsWeb=$kIsWeb)',
    );
  }

  final http.Client _client;
  final String _baseUrl;
  final Duration _timeout;

  Uri _uri(String path) => Uri.parse('$_baseUrl$path');

  Future<bool> checkHealth() async {
    final url = _uri('/');
    ConsultationFeatureLog.d('GET health check → $url');
    try {
      final response = await _client.get(url).timeout(_timeout);
      _logResponse('GET /', response);
      return response.statusCode == 200;
    } catch (e, st) {
      ConsultationFeatureLog.e('Health check failed', e, st);
      return false;
    }
  }

  Future<List<DateTime>> getBookedSlots() async {
    final url = _uri('/v1/consultations/slots');
    ConsultationFeatureLog.d('GET booked slots → $url');
    final response = await _send(() => _client.get(url));
    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw ConsultationApiException(
        messageKey: 'consultation.error.unexpected',
        statusCode: response.statusCode,
      );
    }
    final raw = decoded['data'];
    if (raw is! List) {
      throw ConsultationApiException(
        messageKey: 'consultation.error.unexpected',
        statusCode: response.statusCode,
      );
    }
    final slots = raw
        .whereType<String>()
        .map(DateTime.tryParse)
        .whereType<DateTime>()
        .toList(growable: false);
    ConsultationFeatureLog.d('Parsed ${slots.length} booked slot(s)');
    return slots;
  }

  Future<void> createReservation({
    required String name,
    required String email,
    String? note,
    DateTime? dateUtc,
    ConsultationAttachment? attachment,
  }) async {
    final trimmedName = name.trim();
    final trimmedEmail = email.trim();
    if (trimmedName.isEmpty || trimmedEmail.isEmpty) {
      ConsultationFeatureLog.e(
        'createReservation blocked: name or email empty '
        '(name="$trimmedName", email="$trimmedEmail")',
      );
      throw ConsultationApiException(
        messageKey: 'consultation.error.request',
        serverMessage: 'Name and email are required.',
      );
    }

    final url = _uri('/v1/consultations/reservations');
    final request = http.MultipartRequest('POST', url);

    request.fields['name'] = trimmedName;
    request.fields['email'] = trimmedEmail;

    final trimmedNote = note?.trim();
    if (trimmedNote != null && trimmedNote.isNotEmpty) {
      request.fields['note'] = trimmedNote;
    }

    String? dateField;
    if (dateUtc != null) {
      dateField = formatConsultationDateForApi(dateUtc);
      request.fields['date'] = dateField;
    }

    if (attachment != null) {
      ConsultationFeatureLog.d(
        'Attachment: name=${attachment.fileName}, '
        'size=${attachment.sizeBytes} bytes, '
        'hasBytes=${attachment.bytes != null}, '
        'hasPath=${attachment.filePath != null}',
      );
      final multipart = await _attachmentToMultipart(attachment);
      request.files.add(multipart);
    }

    _logMultipartRequest(request, dateField: dateField);

    try {
      final streamed = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamed);
      _logResponse('POST /v1/consultations/reservations', response);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        ConsultationFeatureLog.d('Reservation created successfully');
        return;
      }
      throw _exceptionFromResponse(response);
    } on ConsultationApiException {
      rethrow;
    } on TimeoutException catch (e, st) {
      ConsultationFeatureLog.e('Reservation request timed out', e, st);
      throw ConsultationApiException(
        messageKey: 'consultation.error.timeout',
      );
    } catch (e, st) {
      ConsultationFeatureLog.e(
        'Reservation request failed (possible CORS/network on Web)',
        e,
        st,
      );
      throw ConsultationApiException(
        messageKey: 'consultation.error.network',
        serverMessage: kIsWeb
            ? 'Network or CORS error. Check the browser console for details.'
            : null,
      );
    }
  }

  void _logMultipartRequest(
    http.MultipartRequest request, {
    String? dateField,
  }) {
    final buffer = StringBuffer()
      ..writeln('POST ${request.url}')
      ..writeln('Content-Type: multipart/form-data (boundary set by client)')
      ..writeln('Fields:');
    for (final entry in request.fields.entries) {
      buffer.writeln('  ${entry.key}=${entry.value}');
    }
    if (dateField != null) {
      buffer.writeln('  (date sent as API format: $dateField)');
    }
    for (final file in request.files) {
      buffer.writeln(
        '  file: filename=${file.filename}, length=${file.length}, '
        'field=${file.field}',
      );
    }
    ConsultationFeatureLog.d(buffer.toString());
  }

  void _logResponse(String label, http.Response response) {
    ConsultationFeatureLog.d(
      '$label response:\n'
      '  status=${response.statusCode}\n'
      '  headers=${response.headers}\n'
      '  body=${response.body}',
    );
  }

  Future<http.MultipartFile> _attachmentToMultipart(
    ConsultationAttachment attachment,
  ) async {
    final bytes = attachment.bytes;
    if (bytes != null && bytes.isNotEmpty) {
      return http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: attachment.fileName,
      );
    }
    final path = attachment.filePath;
    if (!kIsWeb && path != null && path.isNotEmpty) {
      return http.MultipartFile.fromPath(
        'file',
        path,
        filename: attachment.fileName,
      );
    }
    throw ConsultationApiException(
      messageKey: 'consultation.attachment.error.read',
    );
  }

  Future<http.Response> _send(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request().timeout(_timeout);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      }
      throw _exceptionFromResponse(response);
    } on ConsultationApiException {
      rethrow;
    } on TimeoutException catch (e, st) {
      ConsultationFeatureLog.e('Request timed out', e, st);
      throw ConsultationApiException(
        messageKey: 'consultation.error.timeout',
      );
    } catch (e, st) {
      ConsultationFeatureLog.e('Request failed', e, st);
      throw ConsultationApiException(
        messageKey: 'consultation.error.network',
        serverMessage: kIsWeb
            ? 'Network or CORS error. Check the browser console for details.'
            : null,
      );
    }
  }

  ConsultationApiException _exceptionFromResponse(http.Response response) {
    ConsultationFeatureLog.e(
      'API error response body: ${response.body}',
    );

    String? serverMessage;
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        final message = decoded['message'];
        if (message is String && message.isNotEmpty) {
          serverMessage = message;
        }
      }
    } catch (e, st) {
      ConsultationFeatureLog.e('Failed to parse error JSON', e, st);
    }

    final status = response.statusCode;
    final messageKey = status >= 500
        ? 'consultation.error.server'
        : status >= 400
        ? 'consultation.error.request'
        : 'consultation.error.unexpected';

    return ConsultationApiException(
      messageKey: messageKey,
      serverMessage: serverMessage,
      statusCode: status,
    );
  }

  void dispose() => _client.close();
}

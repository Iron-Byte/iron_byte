import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:iron_byte/core/constants/app_constants.dart';
import 'package:iron_byte/features/home/data/consultation_api_exception.dart';
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
       _timeout = timeout;

  final http.Client _client;
  final String _baseUrl;
  final Duration _timeout;

  Uri _uri(String path) => Uri.parse('$_baseUrl$path');

  Future<bool> checkHealth() async {
    final url = _uri('/');
    try {
      final response = await _client.get(url).timeout(_timeout);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<void> createReservation({
    required String name,
    required String email,
    String? note,
    ConsultationAttachment? attachment,
  }) async {
    final trimmedName = name.trim();
    final trimmedEmail = email.trim();
    if (trimmedName.isEmpty || trimmedEmail.isEmpty) {
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

    if (attachment != null) {
      final multipart = await _attachmentToMultipart(attachment);
      request.files.add(multipart);
    }

    try {
      final streamed = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return;
      }
      throw _exceptionFromResponse(response);
    } on ConsultationApiException {
      rethrow;
    } on TimeoutException {
      throw ConsultationApiException(
        messageKey: 'consultation.error.timeout',
      );
    } catch (_) {
      throw ConsultationApiException(
        messageKey: 'consultation.error.network',
        serverMessage: kIsWeb
            ? 'Network or CORS error. Check the browser console for details.'
            : null,
      );
    }
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

  ConsultationApiException _exceptionFromResponse(http.Response response) {
    String? serverMessage;
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        final message = decoded['message'];
        if (message is String && message.isNotEmpty) {
          serverMessage = message;
        }
      }
    } catch (_) {
      // Non-JSON error bodies are ignored.
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

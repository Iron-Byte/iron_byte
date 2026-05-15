import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

// BrowserClient uses fetch/XHR with correct CORS behavior on Flutter Web.
import 'package:http/browser_client.dart' show BrowserClient;

/// Platform-appropriate HTTP client for consultation API calls.
http.Client createConsultationHttpClient() {
  if (kIsWeb) {
    return BrowserClient();
  }
  return http.Client();
}

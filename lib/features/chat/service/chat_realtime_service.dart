import 'dart:async';
import 'dart:convert';

import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/utils/shared_pref.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

typedef ChatMessageCallback = void Function(Map<String, dynamic> message);
typedef ChatConnectionCallback = void Function(bool connected);

/// Owns the STOMP connection for one open conversation.
/// REST remains responsible for message persistence and history; STOMP delivers
/// the server's persisted message events to all participants in real time.
class ChatRealtimeService {
  StompClient? _client;
  bool _disposed = false;

  void connect({
    required int conversationId,
    required ChatMessageCallback onMessage,
    required ChatConnectionCallback onConnectionChanged,
  }) {
    if (_disposed || conversationId <= 0) return;

    final token = SharedPref.getStringValue(KeyString.authTokenKey.name);
    if (token.isEmpty) {
      onConnectionChanged(false);
      return;
    }

    final baseUri = Uri.parse(ApiUrls.devBaseUrl);
    final socketUri = Uri(
      scheme: baseUri.scheme == 'https' ? 'wss' : 'ws',
      host: baseUri.host,
      port: baseUri.hasPort ? baseUri.port : null,
      path: '/ws',
    );

    final client = StompClient(
      config: StompConfig(
        url: socketUri.toString(),
        stompConnectHeaders: {'Authorization': 'Bearer $token'},
        // Spring's handshake interceptor authenticates the HTTP upgrade using
        // this header. Do not put JWTs in the URL, where proxies may log them.
        webSocketConnectHeaders: {'Authorization': 'Bearer $token'},
        reconnectDelay: const Duration(seconds: 5),
        heartbeatIncoming: const Duration(seconds: 20),
        heartbeatOutgoing: const Duration(seconds: 20),
        onConnect: (frame) {
          if (_disposed || !identical(_client, client)) return;
          onConnectionChanged(true);
          client.subscribe(
            destination: '/topic/conversation.$conversationId',
            callback: (frame) {
              final body = frame.body;
              if (body == null || body.isEmpty || _disposed) return;
              try {
                final decoded = jsonDecode(body);
                if (decoded is Map) {
                  onMessage(Map<String, dynamic>.from(decoded));
                }
              } on FormatException {
                // Ignore malformed broker frames rather than breaking the chat UI.
              }
            },
          );
        },
        onWebSocketError: (dynamic error) {
          if (!_disposed) onConnectionChanged(false);
        },
        onStompError: (frame) {
          if (!_disposed) onConnectionChanged(false);
        },
      ),
    );

    _client = client;
    client.activate();
  }

  Future<void> disconnect() async {
    final client = _client;
    _client = null;
    if (client != null) {
      await client.deactivate();
    }
  }

  Future<void> dispose() async {
    _disposed = true;
    await disconnect();
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_client/web_socket_client.dart';

class LlamaChatWebService {
  static final _instance = LlamaChatWebService._internal();
  WebSocket? _socket;

  factory LlamaChatWebService() => _instance;

  LlamaChatWebService._internal();

  final StreamController<String> _llmResponseController = StreamController<String>.broadcast();
  Stream<String> get llmResponseStream => _llmResponseController.stream;

  String getWebSocketUrl() {
    if (kIsWeb) {
      return "ws://localhost:8000/ws/chat_llama";
    } else {
      return "ws://10.0.2.2:8000/ws/chat_llama";
    }
  }

  void connect() {
    if (_socket != null) return;
    final url = getWebSocketUrl();
    _socket = WebSocket(Uri.parse(url));

    _socket!.messages.listen((message) {
      final data = json.decode(message);
      if (data['type'] == 'llm_response') {
        _llmResponseController.add(data['data'].toString());
      } else if (data['type'] == 'error') {
        _llmResponseController.add("Error: ${data['message']}");
      }
    });
  }

  void sendQuery(String query) {
    _socket?.send(json.encode({'query': query}));
  }

  void dispose() {
    _llmResponseController.close();
    _socket?.close();
    _socket = null;
  }
}

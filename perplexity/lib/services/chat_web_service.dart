import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_client/web_socket_client.dart';

class ChatWebService {
  static final _instance = ChatWebService._internal();
  WebSocket? _socket;

  factory ChatWebService() => _instance;

  ChatWebService._internal();
  final _searchResultController = StreamController<Map<String, dynamic>>();
  final _contentController = StreamController<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get searchResultStream =>
      _searchResultController.stream;
  Stream<Map<String, dynamic>> get contentStream => _contentController.stream;

  /// Automatically select the correct WebSocket address based on the platform
  String getWebSocketUrl() {
    if (kIsWeb) {
      return "ws://localhost:8000/ws/chat";
    } else {
      // Android emulator uses 10.0.2.2 to connect to localhost
      return "ws://10.0.2.2:8000/ws/chat";
    }
  }

  void connect() {
    if (_socket != null) return; // Avoid duplicate connections
    final url = getWebSocketUrl();
    _socket = WebSocket(Uri.parse(url));

    _socket!.messages.listen((message) {
      final data = json.decode(message);
      if (data['type'] == 'search_result') {
        _searchResultController.add(data);
      } else if (data['type'] == 'llm_response') {
        _contentController.add(data); // Processing llm_response data
      } else if (data['type'] == 'content') {
        _contentController.add(data);
      }
    });
  }

  void chat(String query) {
    print(query);
    print(_socket);
    _socket!.send(json.encode({'query': query}));
  }
}
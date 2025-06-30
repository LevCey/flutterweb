import '../models/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatViewModel extends StateNotifier<List<Message>> {
  ChatViewModel() : super([]);

  void sendMessage(String text) {
    state = [
      ...state,
      Message(text: text, timestamp: DateTime.now(), isMe: true),
    ];
  }
}

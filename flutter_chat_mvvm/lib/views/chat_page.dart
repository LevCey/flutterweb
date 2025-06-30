import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_provider.dart';
import '../models/message.dart';

class ChatPage extends ConsumerWidget {
  ChatPage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final Message msg = messages[index];
                return ListTile(
                  title: Align(
                    alignment:
                        msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: msg.isMe ? Colors.blue[100] : Colors.grey[300],
                      child: Text(msg.text),
                    ),
                  ),
                  subtitle: Align(
                    alignment:
                        msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Text(
                      msg.timestamp.toLocal().toString().substring(0, 16),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      ref
                          .read(chatProvider.notifier)
                          .sendMessage(_controller.text.trim());
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

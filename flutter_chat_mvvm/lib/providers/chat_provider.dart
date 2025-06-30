import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/chat_viewmodel.dart';
import '../models/message.dart';

final chatProvider = StateNotifierProvider<ChatViewModel, List<Message>>(
  (ref) => ChatViewModel(),
);

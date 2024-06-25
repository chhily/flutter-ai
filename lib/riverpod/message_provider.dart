
import 'package:flutter_ai/api/service.dart';
import 'package:flutter_ai/model/chat_message.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>((ref) {
  return ChatMessagesNotifier();
});

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  ChatMessagesNotifier() : super([]) {
    _loadMessages();
  }

  final _box = Hive.box<ChatMessage>('chat_messages');
  bool _isLoading = false; // Track loading state

  void _loadMessages() {
    state = _box.values.toList();
  }

  set isLoading(bool value) {
    _isLoading = value;
  }

  void addMessage(String message, bool isUser) {
    final chatMessage = ChatMessage(
      message: message,
      isUser: isUser,
    );
    _box.add(chatMessage);
    state = [...state, chatMessage];
  }

  void clearMessage() {
    _box.clear();
    state = [];
  }
}

// Define a provider to manage the AI response
final aiResponseProvider =
    FutureProvider.family<String, String>((ref, userMessage) async {
  try {
    final gemini = Gemini.instance;
    final chats = [
      Content(role: 'user', parts: [Parts(text: userMessage)])
    ];

    // Use Future.timeout to limit API call duration
    final response = await gemini.chat(chats, modelName: AIService.aiModel);

    return response?.output ?? "AI response not available";
  } catch (e) {
    return "AI response not available";
  }
});

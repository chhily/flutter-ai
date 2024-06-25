import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ai/riverpod/message_provider.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ai/constant/constant.dart';

import 'widget/loading.dart';
import 'widget/response.dart';
import 'widget/sender.dart';

class AIChatPage extends ConsumerStatefulWidget {
  const AIChatPage({super.key});

  @override
  ConsumerState createState() => _AIChatPageState();
}

class _AIChatPageState extends ConsumerState<AIChatPage> {
  late TextEditingController senderTCT;

  final ScrollController _scrollController = ScrollController();

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final timeoutDuration = const Duration(seconds: 50);

  @override
  void initState() {
    super.initState();
    senderTCT = TextEditingController();
  }

  @override
  void dispose() {
    senderTCT.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (senderTCT.text.isNotEmpty) {
      final userMessage = senderTCT.text;
      senderTCT.clear();

      // Add user message to the state
      ref.read(chatMessagesProvider.notifier).addMessage(userMessage, true);

      // Scroll to bottom after adding user message
      _scrollToBottom();

      // Fetch AI response
      try {
        isLoading.value = true;

        final aiResponse = await ref
            .read(aiResponseProvider(userMessage).future)
            .timeout(timeoutDuration);

        // Add AI response to the state
        ref.read(chatMessagesProvider.notifier).addMessage(aiResponse, false);

        // Scroll to bottom after adding AI response
        _scrollToBottom();
      } on TimeoutException {
        ref
            .read(chatMessagesProvider.notifier)
            .addMessage("Timeout connection error", false);

        Gemini.instance.cancelRequest();
      } catch (e) {
        debugPrint("Something went wrong ! $e");
      } finally {
        if (context.mounted) {
          context.hideKeyboard();
        }
        isLoading.value = false;
      }
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _clearChat() {
    ref.read(chatMessagesProvider.notifier).clearMessage();
  }

  @override
  Widget build(BuildContext context) {
    final chatMessages = ref.watch(chatMessagesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI CHAT"),
        actions: [
          IconButton(
            onPressed: () {
              _clearChat();
            },
            icon: const Text("CLEAR"),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => context.hideKeyboard(),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final chatMessage = chatMessages.reversed.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: chatMessage.isUser
                        ? SenderWidget(senderText: chatMessage.message)
                        : ResponseWidget(responseText: chatMessage.message),
                  );
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                if (value) {
                  return const LoadingWidget();
                }
                return const SizedBox();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: senderTCT,
                      decoration: inputDecoration.copyWith(
                        hintText: 'Type your message...',
                        hintStyle: appTextStyle,
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.insert_photo_rounded,
                            color: AppColors.white,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.white,
                          ),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/ai_chat_repository_impl.dart';
import '../../data/services/demo_ai_reply_service.dart';
import '../../data/sources/ai_chat_mock_source.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/ai_chat_repository.dart';

class AiChatState {
  const AiChatState({required this.messages, required this.quickRequests});

  final List<ChatMessageEntity> messages;
  final List<String> quickRequests;

  AiChatState copyWith({
    List<ChatMessageEntity>? messages,
    List<String>? quickRequests,
  }) {
    return AiChatState(
      messages: messages ?? this.messages,
      quickRequests: quickRequests ?? this.quickRequests,
    );
  }
}

final aiChatMockSourceProvider = Provider<AiChatMockSource>((ref) {
  return const AiChatMockSource();
});

final demoAiReplyServiceProvider = Provider<DemoAiReplyService>((ref) {
  return const DemoAiReplyService();
});

final aiChatRepositoryProvider = Provider<AiChatRepository>((ref) {
  return AiChatRepositoryImpl(
    source: ref.watch(aiChatMockSourceProvider),
    replyService: ref.watch(demoAiReplyServiceProvider),
  );
});

final aiChatProvider = StateNotifierProvider<AiChatNotifier, AiChatState>((
  ref,
) {
  return AiChatNotifier(ref.watch(aiChatRepositoryProvider));
});

class AiChatNotifier extends StateNotifier<AiChatState> {
  AiChatNotifier(this.repository)
    : super(
        AiChatState(
          messages: [repository.getInitialMessage()],
          quickRequests: repository.getQuickRequests(),
        ),
      );

  final AiChatRepository repository;

  void addUserMessage(String text) {
    state = state.copyWith(
      messages: [
        ...state.messages,
        ChatMessageEntity(text: text, isUser: true),
        const ChatMessageEntity(
          text: 'AI yozmoqda...',
          isUser: false,
          isTyping: true,
        ),
      ],
    );
  }

  void addAiReply(String text) {
    state = state.copyWith(
      messages: [
        for (final message in state.messages)
          if (!message.isTyping) message,
        ChatMessageEntity(text: repository.generateReply(text), isUser: false),
      ],
    );
  }
}

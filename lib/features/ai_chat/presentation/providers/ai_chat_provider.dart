import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/ai_chat_repository_impl.dart';
import '../../data/services/supabase_ai_chat_service.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/ai_chat_repository.dart';

class AiChatState {
  const AiChatState({required this.messages});

  final List<ChatMessageEntity> messages;

  AiChatState copyWith({
    List<ChatMessageEntity>? messages,
  }) {
    return AiChatState(
      messages: messages ?? this.messages,
    );
  }
}

final supabaseAiChatServiceProvider = Provider<SupabaseAiChatService>((ref) {
  return const SupabaseAiChatService();
});

final aiChatRepositoryProvider = Provider<AiChatRepository>((ref) {
  return AiChatRepositoryImpl(
    replyService: ref.watch(supabaseAiChatServiceProvider),
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
        ),
      );

  final AiChatRepository repository;

  Future<void> sendMessage(String text) async {
    final value = text.trim();
    if (value.isEmpty) return;

    state = state.copyWith(
      messages: [
        ...state.messages,
        ChatMessageEntity(text: value, isUser: true),
        const ChatMessageEntity(
          text: 'AI yozmoqda...',
          isUser: false,
          isTyping: true,
        ),
      ],
    );

    final reply = await repository.generateReply(value);
    if (!mounted) return;

    state = state.copyWith(
      messages: [
        for (final message in state.messages)
          if (!message.isTyping) message,
        ChatMessageEntity(text: reply, isUser: false),
      ],
    );
  }
}

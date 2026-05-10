import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/ai_chat_repository.dart';
import '../services/supabase_ai_chat_service.dart';
import '../sources/ai_chat_mock_source.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  const AiChatRepositoryImpl({
    required this.source,
    required this.replyService,
  });

  final AiChatMockSource source;
  final SupabaseAiChatService replyService;

  @override
  ChatMessageEntity getInitialMessage() {
    return source.getInitialMessage();
  }

  @override
  Future<String> generateReply(String text) {
    return replyService.generateReply(text);
  }
}

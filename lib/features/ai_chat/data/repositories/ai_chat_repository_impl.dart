import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/ai_chat_repository.dart';
import '../services/supabase_ai_chat_service.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  const AiChatRepositoryImpl({required this.replyService});

  final SupabaseAiChatService replyService;

  @override
  ChatMessageEntity getInitialMessage() {
    return const ChatMessageEntity(
      text:
          'Assalomu aleykum! Men sizga mos ish topishda yordam beraman. Qanday ish qidiryapsiz?',
      isUser: false,
    );
  }

  @override
  Future<String> generateReply(String text) {
    return replyService.generateReply(text);
  }
}

import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/ai_chat_repository.dart';
import '../services/demo_ai_reply_service.dart';
import '../sources/ai_chat_mock_source.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  const AiChatRepositoryImpl({
    required this.source,
    required this.replyService,
  });

  final AiChatMockSource source;
  final DemoAiReplyService replyService;

  @override
  ChatMessageEntity getInitialMessage() {
    return source.getInitialMessage();
  }

  @override
  List<String> getQuickRequests() {
    return source.getQuickRequests();
  }

  @override
  String generateReply(String text) {
    return replyService.generateReply(text);
  }
}

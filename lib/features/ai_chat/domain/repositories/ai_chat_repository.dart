import '../entities/chat_message_entity.dart';

abstract class AiChatRepository {
  ChatMessageEntity getInitialMessage();

  List<String> getQuickRequests();

  String generateReply(String text);
}

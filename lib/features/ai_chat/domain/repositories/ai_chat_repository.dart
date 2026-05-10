import '../entities/chat_message_entity.dart';

abstract class AiChatRepository {
  ChatMessageEntity getInitialMessage();

  Future<String> generateReply(String text);
}

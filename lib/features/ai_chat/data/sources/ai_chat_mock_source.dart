import '../models/chat_message_model.dart';

class AiChatMockSource {
  const AiChatMockSource();

  ChatMessageModel getInitialMessage() {
    return const ChatMessageModel(
      text:
          'Assalomu aleykum! Men sizga mos ish topishda yordam beraman. Qanday ish qidiryapsiz?',
      isUser: false,
    );
  }
}

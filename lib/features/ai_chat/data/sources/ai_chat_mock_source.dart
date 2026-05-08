import '../models/chat_message_model.dart';

class AiChatMockSource {
  const AiChatMockSource();

  ChatMessageModel getInitialMessage() {
    return const ChatMessageModel(
      text:
          'Salom! рџ‘‹ Men sizga mos ish topishda yordam beraman. Qanday ish qidiryapsiz?',
      isUser: false,
    );
  }

  List<String> getQuickRequests() {
    return const [
      'Koreyada zavod ishi',
      'IT remote ishlar',
      'Toshkentda ish',
      'Yuqori maoshli ishlar',
    ];
  }
}

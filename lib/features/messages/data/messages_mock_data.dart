import '../models/conversation_model.dart';
import '../models/message_model.dart';

class MessagesMockData {
  static const conversations = [
    ConversationModel(
      name: 'AI Support',
      message: 'Salom! Sizga qanday yordam...',
      time: '10:45',
      avatar: '🤖',
      unread: '2',
      verified: true,
    ),
    ConversationModel(
      name: 'Asrorbek HR',
      message: 'Sizning resumeingizni ko‘rib chiqdim.',
      time: '10:32',
      avatar: '👨‍💼',
      unread: '1',
      verified: false,
    ),
    ConversationModel(
      name: 'Malika Recruiter',
      message: 'Interview haqida ma’lumot yuborildi.',
      time: '09:18',
      avatar: '👩‍💼',
      unread: '',
      verified: false,
    ),
    ConversationModel(
      name: 'Job Korea Team 🇰🇷',
      message: 'Yangi ish o‘rinlari keldi!',
      time: '08:50',
      avatar: '👨‍💻',
      unread: '3',
      verified: false,
    ),
    ConversationModel(
      name: 'Dubai Jobs',
      message: 'Hujjatlaringiz qabul qilindi.',
      time: 'Yesterday',
      avatar: '👩',
      unread: '',
      verified: false,
    ),
    ConversationModel(
      name: 'Workora Team',
      message: 'Yangi funksiya qo‘shildi 🚀',
      time: 'Tue',
      avatar: '👩‍💻',
      unread: '2',
      verified: true,
    ),
  ];

  static const messages = [
    MessageModel(
      text: 'Salom! Sizga qanday yordam bera olaman? 😊',
      isMe: false,
    ),
    MessageModel(
      text: 'Salom, men Koreyada zavod ishi haqida ma’lumot olmoqchiman.',
      isMe: true,
    ),
    MessageModel(
      text:
          'Albatta! Koreyada zavod ishlari haqida sizga to‘liq ma’lumot beraman.',
      isMe: false,
    ),
    MessageModel(text: 'Ish haqi qancha bo‘ladi?', isMe: true),
    MessageModel(
      text:
          'Odatda oylik maosh \$1200 - \$1800 atrofida bo‘ladi. Yotoqxona va ovqat bilan ta’minlanadi.',
      isMe: false,
    ),
  ];
}

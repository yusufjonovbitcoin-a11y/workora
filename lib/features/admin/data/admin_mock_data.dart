import '../models/admin_message_model.dart';
import '../models/admin_user_model.dart';
import '../models/admin_vacancy_model.dart';
import '../models/application_model.dart';

class AdminMockData {
  const AdminMockData._();

  static const users = [
    AdminUserModel(
      id: 'u1',
      name: 'Muhammadamin',
      phone: '+998 90 123 45 67',
      profession: 'Flutter Developer',
      location: 'Toshkent',
      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
      skills: ['Flutter', 'Dart', 'UI/UX'],
      applications: 12,
      savedJobs: 8,
      aiMatch: 92,
      isActive: true,
      isVerified: true,
      isPremium: true,
    ),
    AdminUserModel(
      id: 'u2',
      name: 'Aziza Karimova',
      phone: '+998 91 222 33 44',
      profession: 'SMM Manager',
      location: 'Samarqand',
      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
      skills: ['Marketing', 'Canva', 'Copywriting'],
      applications: 5,
      savedJobs: 11,
      aiMatch: 84,
      isActive: true,
      isVerified: false,
      isPremium: false,
    ),
    AdminUserModel(
      id: 'u3',
      name: 'Javohir Aliyev',
      phone: '+998 93 555 77 88',
      profession: 'Factory Worker',
      location: 'Farg‘ona',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
      skills: ['Zavod', 'Koreys tili A2', 'Texnika'],
      applications: 18,
      savedJobs: 6,
      aiMatch: 89,
      isActive: false,
      isVerified: true,
      isPremium: false,
    ),
  ];

  static const vacancies = [
    AdminVacancyModel(
      id: 'v1',
      title: 'Factory Worker',
      company: 'Samsung Korea',
      location: 'Seul',
      salary: '\$2,200 - \$2,800',
      status: 'active',
      type: 'To‘liq ish vaqti',
      applications: 46,
      isForeign: true,
      country: 'Koreya',
      contract: '3 yil',
      housing: 'Yotoqxona bor',
      visa: 'Viza yordami',
      requirements: ['18-45 yosh', 'Sog‘lom', 'Pasport tayyor'],
      benefits: ['Uy-joy', 'Sug‘urta', 'Transport'],
    ),
    AdminVacancyModel(
      id: 'v2',
      title: 'Flutter Developer',
      company: 'Startup AI',
      location: 'Remote',
      salary: '\$1,500 - \$2,500',
      status: 'draft',
      type: 'Remote',
      applications: 21,
      isForeign: false,
      country: 'Uzbekistan',
      contract: '1 yil',
      housing: 'Yo‘q',
      visa: 'Kerak emas',
      requirements: ['Flutter', 'REST API', 'Git'],
      benefits: ['Remote', 'Flexible time', 'Bonus'],
    ),
    AdminVacancyModel(
      id: 'v3',
      title: 'Hotel Assistant',
      company: 'Dubai Hotel Group',
      location: 'Dubai',
      salary: '\$1,000 - \$1,500',
      status: 'pending',
      type: 'Shartnoma',
      applications: 33,
      isForeign: true,
      country: 'BAA',
      contract: '2 yil',
      housing: 'Bepul',
      visa: 'Kompaniya qiladi',
      requirements: ['Ingliz tili A2', 'Xushmuomala', 'Tajriba afzal'],
      benefits: ['Yotoqxona', 'Ovqat', 'Transport'],
    ),
  ];

  static const applications = [
    ApplicationModel(
      id: 'a1',
      applicant: 'Muhammadamin',
      vacancy: 'Factory Worker',
      company: 'Samsung Korea',
      status: 'interview',
      date: '2026-05-08',
    ),
    ApplicationModel(
      id: 'a2',
      applicant: 'Aziza Karimova',
      vacancy: 'SMM Manager',
      company: 'Marketing Pro',
      status: 'viewed',
      date: '2026-05-07',
    ),
    ApplicationModel(
      id: 'a3',
      applicant: 'Javohir Aliyev',
      vacancy: 'Hotel Assistant',
      company: 'Dubai Hotel Group',
      status: 'sent',
      date: '2026-05-06',
    ),
  ];

  static const messages = [
    AdminMessageModel(
      id: 'm1',
      user: 'Muhammadamin',
      lastMessage: 'Vakansiya holati qanday?',
      time: '10:45',
      unread: 2,
      messages: [
        ChatLineModel(text: 'Salom, yordam kerak edi.', isAdmin: false),
        ChatLineModel(text: 'Albatta, qanday yordam beramiz?', isAdmin: true),
        ChatLineModel(text: 'Vakansiya holati qanday?', isAdmin: false),
      ],
    ),
    AdminMessageModel(
      id: 'm2',
      user: 'Aziza Karimova',
      lastMessage: 'CV yuklashda muammo bor',
      time: '09:20',
      unread: 1,
      messages: [
        ChatLineModel(text: 'CV yuklashda muammo bor', isAdmin: false),
      ],
    ),
  ];

  static const activities = [
    'Yangi foydalanuvchi ro‘yxatdan o‘tdi',
    'Samsung Korea vakansiyasi tasdiqlandi',
    'AI Chat 124 ta so‘rovni qayta ishladi',
    'Dubai Hotel Group yangi ariza oldi',
  ];
}

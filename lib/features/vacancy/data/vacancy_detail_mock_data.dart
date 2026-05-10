import '../models/vacancy_detail_model.dart';

class VacancyDetailMockData {
  const VacancyDetailMockData._();

  static const vacancy = VacancyDetailModel(
    id: 'mock-factory-worker',
    title: 'Factory Worker',
    company: 'Samsung Korea',
    verified: true,
    logo: 'SAMSUNG',
    match: '92%',
    location: 'Koreya, Seul',
    salary: '\$2,200 - \$2,800',
    jobType: 'To‘liq ish vaqti',
    contractType: 'Shartnoma asosida',
    description:
        'Samsung Korea zavodida ishlab chiqarish liniyasida ishlash uchun mas’uliyatli va jismonan sog‘lom nomzodlar qabul qilinadi. Ish jarayonida mahsulotlarni yig‘ish, qadoqlash va sifat nazoratida qatnashish vazifalari mavjud.',
    startDate: '2024-07-15',
    employeesNeeded: '20 nafar',
    languageRequirement: 'Koreyscha (boshlang‘ich)',
    housing: 'Kompaniya ta’minlaydi',
    requirements: [
      '18 - 45 yosh oralig‘ida',
      'Jismoniy jihatdan sog‘lom',
      'Pasport va hujjatlari to‘liq bo‘lishi',
      'Disiplinli va mas’uliyatli bo‘lish',
      'Ish tajribasi bo‘lsa afzal',
      'Koreys tilini boshlang‘ich bilish afzal',
    ],
    benefits: [
      'Raqobatbardosh maosh',
      'Yashash joyi bepul',
      'Tibbiy sug‘urta',
      'Transport xizmati',
      'Ovqatlanish yordami',
      'Viza bo‘yicha yordam',
    ],
    companyDescription:
        'Samsung Korea xalqaro texnologiya va ishlab chiqarish kompaniyasi bo‘lib, xodimlar uchun barqaror ish sharoiti, o‘sish imkoniyati va zamonaviy ishlab chiqarish muhitini taqdim etadi.',
    companyLocation: 'Seul, Koreya',
    companyEmployees: '10 000+',
    companyActiveVacancies: '24 ta',
    reviews: [
      ReviewModel(
        userName: 'Azizbek',
        rating: 4.8,
        comment: 'Ish sharoiti yaxshi, yotoqxona va transport masalasi qulay.',
        date: '2024-05-12',
      ),
      ReviewModel(
        userName: 'Dilnoza',
        rating: 4.6,
        comment: 'Hujjat tayyorlashda yordam berishdi, jarayon ancha tartibli.',
        date: '2024-04-28',
      ),
      ReviewModel(
        userName: 'Jahongir',
        rating: 4.9,
        comment: 'Maosh vaqtida tushadi, ish intizomi kuchli.',
        date: '2024-03-19',
      ),
    ],
  );
}

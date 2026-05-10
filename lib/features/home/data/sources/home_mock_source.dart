import '../models/category_model.dart';
import '../models/job_seeker_model.dart';
import '../models/job_model.dart';

class HomeMockSource {
  const HomeMockSource();

  List<CategoryModel> getCategories() {
    return const [
      CategoryModel(title: 'IT'),
      CategoryModel(title: 'Design'),
      CategoryModel(title: 'Marketing'),
      CategoryModel(title: 'Factory'),
      CategoryModel(title: 'Remote'),
      CategoryModel(title: 'AI'),
    ];
  }

  List<JobModel> getRecommendedJobs() {
    final now = DateTime.now();
    return [
      JobModel(
        id: 'mock-factory-worker',
        title: 'Factory Worker',
        company: 'Samsung Korea',
        location: 'Korea',
        salary: '\$2200',
        match: '92%',
        logo: 'SAMSUNG',
        category: 'Factory',
        jobType: 'To‘liq ish vaqti',
        createdAt: now.subtract(const Duration(days: 5)),
      ),
      JobModel(
        id: 'mock-ui-ux-designer',
        title: 'UI/UX Designer',
        company: 'Google',
        location: 'Remote',
        salary: '\$4500',
        match: '87%',
        logo: 'G',
        category: 'Design',
        jobType: 'Remote',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      JobModel(
        id: 'mock-flutter-developer',
        title: 'Flutter Developer',
        company: 'Startup AI',
        location: 'Tashkent',
        salary: '\$3500',
        match: '95%',
        logo: 'F',
        category: 'IT',
        jobType: 'To‘liq ish vaqti',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    ];
  }

  List<JobSeekerModel> getJobSeekers() {
    return const [
      JobSeekerModel(
        id: 'mock-seeker-smm',
        profession: 'SMM mutaxassisi',
        jobType: 'To‘liq stavka',
        location: 'Toshkent',
        expectedSalary: '8 000 000 so‘m',
        experience: '1 yil',
        skills: ['Instagram', 'Canva', 'Kontent reja'],
        education: 'Kurslar',
        languages: ['O‘zbekcha', 'Ruscha'],
        about:
            'Brendlar uchun kontent yaratish va sahifa yuritish tajribam bor.',
        contact: '@workora_demo',
      ),
    ];
  }
}

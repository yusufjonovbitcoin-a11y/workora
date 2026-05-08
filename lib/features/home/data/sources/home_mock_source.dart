import '../models/category_model.dart';
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
    return const [
      JobModel(
        title: 'Factory Worker',
        company: 'Samsung Korea',
        location: 'Korea',
        salary: '\$2200',
        match: '92%',
        logo: 'SAMSUNG',
      ),
      JobModel(
        title: 'UI/UX Designer',
        company: 'Google',
        location: 'Remote',
        salary: '\$4500',
        match: '87%',
        logo: 'G',
      ),
      JobModel(
        title: 'Flutter Developer',
        company: 'Startup AI',
        location: 'Tashkent',
        salary: '\$3500',
        match: '95%',
        logo: 'F',
      ),
    ];
  }
}

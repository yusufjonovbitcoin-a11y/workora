class HomeJobFilters {
  const HomeJobFilters({
    required this.categories,
    required this.jobType,
    required this.locationQuery,
    required this.salaryMin,
    required this.salaryMax,
    required this.experience,
    required this.sortNewestFirst,
  });

  factory HomeJobFilters.initial() => HomeJobFilters(
        categories: [],
        jobType: 'Barchasi',
        locationQuery: '',
        salaryMin: 200,
        salaryMax: 5000,
        experience: "Boshlang‘ich",
        sortNewestFirst: true,
      );

  final List<String> categories;
  final String jobType;
  final String locationQuery;
  final double salaryMin;
  final double salaryMax;
  final String experience;
  final bool sortNewestFirst;

  HomeJobFilters copyWith({
    List<String>? categories,
    String? jobType,
    String? locationQuery,
    double? salaryMin,
    double? salaryMax,
    String? experience,
    bool? sortNewestFirst,
  }) {
    return HomeJobFilters(
      categories: categories ?? List<String>.from(this.categories),
      jobType: jobType ?? this.jobType,
      locationQuery: locationQuery ?? this.locationQuery,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
      experience: experience ?? this.experience,
      sortNewestFirst: sortNewestFirst ?? this.sortNewestFirst,
    );
  }

  static HomeJobFilters clone(HomeJobFilters other) {
    return HomeJobFilters(
      categories: List<String>.from(other.categories),
      jobType: other.jobType,
      locationQuery: other.locationQuery,
      salaryMin: other.salaryMin,
      salaryMax: other.salaryMax,
      experience: other.experience,
      sortNewestFirst: other.sortNewestFirst,
    );
  }
}

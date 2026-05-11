import 'entities/home_job_filters.dart';
import 'entities/job_entity.dart';
import 'entities/job_seeker_entity.dart';

String _normalize(String value) {
  return value
      .toLowerCase()
      .replaceAll('‘', "'")
      .replaceAll('ʼ', "'")
      .trim();
}

(double, double)? _usdBounds(String salary) {
  final matches = RegExp(r'\$(\d[\d,]*)').allMatches(salary);
  if (matches.isEmpty) return null;
  final values = matches
      .map((m) => double.tryParse(m.group(1)!.replaceAll(',', '')))
      .whereType<double>()
      .toList();
  if (values.isEmpty) return null;
  var low = values.first;
  var high = values.first;
  for (final v in values) {
    if (v < low) low = v;
    if (v > high) high = v;
  }
  return (low, high);
}

bool _salaryOverlaps(String salary, double minUsd, double maxUsd) {
  final bounds = _usdBounds(salary);
  if (bounds == null) return true;
  final (low, high) = bounds;
  return !(high < minUsd || low > maxUsd);
}

bool jobTypeMatchesFilter(String selected, String jobType) {
  final j = _normalize(jobType);
  if (j.isEmpty) return true;
  final s = _normalize(selected);
  // "Barchasi" yoki bo'sh — ish turini filtrlashmaymiz (bosh sahifada barcha vakansiyalar chiqsin).
  if (s.isEmpty || s == 'barchasi') {
    return true;
  }
  if (s.contains('toliq') && s.contains('vaqt')) {
    return j.contains('toliq') ||
        j.contains('full-time') ||
        j.contains('full time') ||
        j.contains('ish vaqti');
  }
  if (s.contains('qisman')) {
    return j.contains('qisman') ||
        j.contains('part') ||
        j.contains('yarim');
  }
  if (s.contains('staj')) {
    return j.contains('staj') || j.contains('intern');
  }
  if (s.contains('freelance')) {
    return j.contains('freelance') ||
        j.contains('remote') ||
        j.contains('contract');
  }
  return j.contains(s);
}

bool categoryMatchesJob(JobEntity job, List<String> chips) {
  if (chips.isEmpty) return true;
  final hay = _normalize('${job.category} ${job.title}');
  for (final chip in chips) {
    final c = _normalize(chip);
    if (c.contains('ui/ux') || c == 'uiux') {
      if (hay.contains('ui') ||
          hay.contains('ux') ||
          hay.contains('design')) {
        return true;
      }
      continue;
    }
    if (hay.contains(c)) return true;
  }
  return false;
}

int? _leadingYears(String experience) {
  final m = RegExp(r'^(\d+)').firstMatch(experience.trim());
  if (m == null) return null;
  return int.tryParse(m.group(1)!);
}

bool experienceMatchesSeeker(String level, String seekerExperience) {
  final years = _leadingYears(seekerExperience);
  final e = _normalize(seekerExperience);
  final l = _normalize(level);
  if (l.contains('boshlang')) {
    return years == null ||
        years < 2 ||
        e.contains('staj') ||
        e.contains('boshlang');
  }
  if (l.contains('orta')) {
    return years != null && years >= 2 && years < 5;
  }
  if (l.contains('yuqori')) {
    return years != null && years >= 5 && years < 8;
  }
  if (l.contains('ekspert')) {
    return (years != null && years >= 8) || e.contains('ekspert');
  }
  return true;
}

bool jobMatchesSearch(JobEntity job, String query) {
  final normalized = query.trim().toLowerCase();
  if (normalized.isEmpty) return true;
  return [
    job.title,
    job.company,
    job.location,
    job.salary,
    job.category,
    job.jobType,
  ].any((value) => value.toLowerCase().contains(normalized));
}

bool seekerMatchesSearch(JobSeekerEntity seeker, String query) {
  final normalized = query.trim().toLowerCase();
  if (normalized.isEmpty) return true;
  return [
    seeker.profession,
    seeker.jobType,
    seeker.location,
    seeker.expectedSalary,
    seeker.experience,
    seeker.education,
    seeker.about,
    seeker.contact,
    ...seeker.skills,
    ...seeker.languages,
  ].any((value) => value.toLowerCase().contains(normalized));
}

bool seekerMatchesFilters(JobSeekerEntity seeker, HomeJobFilters filters) {
  if (!jobTypeMatchesFilter(filters.jobType, seeker.jobType)) {
    return false;
  }
  if (filters.locationQuery.trim().isNotEmpty) {
    final q = _normalize(filters.locationQuery);
    if (!_normalize(seeker.location).contains(q)) return false;
  }
  if (!_salaryOverlaps(seeker.expectedSalary, filters.salaryMin, filters.salaryMax)) {
    return false;
  }
  if (!experienceMatchesSeeker(filters.experience, seeker.experience)) {
    return false;
  }
  return true;
}

bool jobMatchesFilters(JobEntity job, HomeJobFilters filters) {
  if (!categoryMatchesJob(job, filters.categories)) return false;
  if (!jobTypeMatchesFilter(filters.jobType, job.jobType)) return false;
  if (filters.locationQuery.trim().isNotEmpty) {
    final q = _normalize(filters.locationQuery);
    if (!_normalize(job.location).contains(q)) return false;
  }
  if (!_salaryOverlaps(job.salary, filters.salaryMin, filters.salaryMax)) {
    return false;
  }
  return true;
}

List<JobEntity> applyHomeJobFilters(
  List<JobEntity> jobs,
  String query,
  HomeJobFilters filters,
) {
  final filtered = jobs
      .where((job) => jobMatchesSearch(job, query) && jobMatchesFilters(job, filters))
      .toList(growable: false);

  if (!filters.sortNewestFirst) return filtered;

  final copy = List<JobEntity>.from(filtered);
  copy.sort((a, b) {
    final da = a.createdAt;
    final db = b.createdAt;
    if (da == null && db == null) return 0;
    if (da == null) return 1;
    if (db == null) return -1;
    return db.compareTo(da);
  });
  return copy;
}

List<JobSeekerEntity> applyHomeSeekerFilters(
  List<JobSeekerEntity> seekers,
  String query,
  HomeJobFilters filters,
) {
  return seekers
      .where(
        (s) =>
            seekerMatchesSearch(s, query) && seekerMatchesFilters(s, filters),
      )
      .toList(growable: false);
}

int homeFilterMatchCount(
  List<JobEntity> jobs,
  List<JobSeekerEntity> seekers,
  String query,
  HomeJobFilters filters,
) {
  return applyHomeJobFilters(jobs, query, filters).length +
      applyHomeSeekerFilters(seekers, query, filters).length;
}

import '../../profile/models/profile_record.dart';
import 'entities/job_entity.dart';

/// Supabase `match_score` (yoki allaqachon formatlangan `job.match`) dan foiz.
int parsePercentFromJobMatchLabel(String match) {
  final m = RegExp(r'(\d{1,3})').firstMatch(match.trim());
  if (m == null) return 68;
  final v = int.tryParse(m.group(1)!);
  if (v == null) return 68;
  return v.clamp(0, 100);
}

/// DB qatoridagi `match_score` (int/double/string/null).
String formatMatchFromDbRaw(Object? value) {
  if (value == null) return '68%';
  final text = value.toString().trim();
  if (text.isEmpty) return '68%';
  if (text.endsWith('%')) {
    final inner = text.replaceAll('%', '').trim();
    final n = int.tryParse(inner.split('.').first);
    if (n == null) return '68%';
    return '${n.clamp(0, 100)}%';
  }
  final n = int.tryParse(text.split('.').first);
  if (n == null) return '68%';
  return '${n.clamp(0, 100)}%';
}

String _n(String s) {
  return s
      .toLowerCase()
      .replaceAll('‘', "'")
      .replaceAll('ʼ', "'")
      .trim();
}

/// Joriy profil va vakansiya matnlariga qarab taxminiy moslik (38–98).
int computePersonalizedMatchPercent(JobEntity job, ProfileRecord profile) {
  final hay = _n(
    '${job.title} ${job.category} ${job.jobType} ${job.location} ${job.company}',
  );
  if (hay.isEmpty) return parsePercentFromJobMatchLabel(job.match);

  var score = 30;

  final prof = _n(profile.profession);
  if (prof.length >= 3) {
    if (hay.contains(prof)) {
      score += 32;
    } else {
      for (final token in prof.split(RegExp(r'\s+')).where((t) => t.length >= 3)) {
        if (hay.contains(token)) {
          score += 14;
          break;
        }
      }
    }
  }

  for (final s in profile.skills) {
    final t = _n(s.title);
    if (t.length >= 2 && hay.contains(t)) {
      score += 6;
    }
  }

  final bio = _n(profile.bio);
  if (bio.length > 24) {
    var extra = 0;
    for (final w in bio.split(RegExp(r'\s+')).where((e) => e.length >= 4).take(16)) {
      if (hay.contains(w)) extra += 3;
    }
    score += extra.clamp(0, 15);
  }

  final loc = _n(profile.location);
  if (loc.length > 2) {
    final head = loc.split(RegExp(r'[,;]')).first.trim();
    if (head.length > 2 && _n(job.location).contains(head)) {
      score += 10;
    }
  }

  for (final e in profile.experiences) {
    final company = _n(e.company);
    final pos = _n(e.position);
    if (company.length > 2 && hay.contains(company)) score += 6;
    if (pos.length > 2 && hay.contains(pos)) score += 5;
  }

  return score.clamp(38, 98);
}

/// Kartochka uchun: profil bo‘lsa va signal bo‘lsa — shaxsiy; aks holda saqlangan foiz.
int effectiveMatchPercent(JobEntity job, ProfileRecord? profile) {
  final fromDb = parsePercentFromJobMatchLabel(job.match);
  if (profile == null) return fromDb;

  final hasSignal = profile.profession.trim().isNotEmpty ||
      profile.skills.isNotEmpty ||
      profile.bio.trim().length > 12;
  if (!hasSignal) return fromDb;

  return computePersonalizedMatchPercent(job, profile);
}

String effectiveMatchLabel(JobEntity job, ProfileRecord? profile) {
  return '${effectiveMatchPercent(job, profile)}%';
}

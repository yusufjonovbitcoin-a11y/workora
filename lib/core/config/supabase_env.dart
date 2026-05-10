/// Dashboarddan ko‘chirishda ba’zan `.../rest/v1/` qo‘shib qo‘yiladi; SDK esa
/// `url + '/auth/v1'` qiladi — natijada `.../rest/v1//auth/v1` va 404 chiqadi.
/// Faqat loyiha ildizi qaytadi: `https://<ref>.supabase.co`.
String normalizeSupabaseProjectUrl(String raw) {
  var u = raw.trim();
  while (u.endsWith('/')) {
    u = u.substring(0, u.length - 1);
  }
  final lower = u.toLowerCase();
  const marker = '/rest/v1';
  if (lower.endsWith(marker)) {
    u = u.substring(0, u.length - marker.length);
    while (u.endsWith('/')) {
      u = u.substring(0, u.length - 1);
    }
  }
  return u;
}

/// `.env` dagi Supabase qiymatlari haqiqatan ishlatishga yaroqlimi (placeholder emas).
bool isSupabaseEnvReady(String url, String anonKey) {
  final u = normalizeSupabaseProjectUrl(url);
  final k = anonKey.trim();
  return u.startsWith('https://') && k.length >= 20 && u != '...' && k != '...';
}

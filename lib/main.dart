import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/config/supabase_env.dart';
import 'core/url_strategy_stub.dart'
    if (dart.library.html) 'core/url_strategy_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureAppUrlStrategy();
  await dotenv.load(fileName: '.env');

  final url = normalizeSupabaseProjectUrl(
    dotenv.env['SUPABASE_URL']?.trim() ?? '',
  );
  final anonKey = dotenv.env['SUPABASE_ANON_KEY']?.trim() ?? '';

  if (isSupabaseEnvReady(url, anonKey)) {
    await Supabase.initialize(url: url, anonKey: anonKey);
  } else {
    debugPrint(
      'Supabase: .env da SUPABASE_URL va SUPABASE_ANON_KEY to‘liq emas — OTP ishlamaydi.',
    );
  }

  runApp(const ProviderScope(child: WorkoraApp()));
}

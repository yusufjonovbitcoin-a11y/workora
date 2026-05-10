import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repositories/add_repository_impl.dart';
import '../../data/sources/supabase_add_source.dart';
import '../../domain/repositories/add_repository.dart';

final addRepositoryProvider = Provider<AddRepository>((ref) {
  if (!Supabase.instance.isInitialized) {
    throw StateError('Supabase sozlanmagan. .env ma’lumotlarini tekshiring.');
  }

  return AddRepositoryImpl(SupabaseAddSource(Supabase.instance.client));
});

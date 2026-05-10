import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../data/sources/supabase_auth_source.dart';
import '../../domain/repositories/auth_repository.dart';

final supabaseAuthSourceProvider = Provider<SupabaseAuthSource>((ref) {
  return SupabaseAuthSource(Supabase.instance.client);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final source = ref.watch(supabaseAuthSourceProvider);
  return AuthRepositoryImpl(source);
});

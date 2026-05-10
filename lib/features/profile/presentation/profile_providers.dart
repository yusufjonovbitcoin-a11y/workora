import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/supabase_profile_repository.dart';

final supabaseProfileRepositoryProvider = Provider<SupabaseProfileRepository>(
  (ref) => SupabaseProfileRepository(Supabase.instance.client),
);

import '../../domain/repositories/auth_repository.dart';
import '../sources/supabase_auth_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._source);

  final SupabaseAuthSource _source;

  @override
  Future<void> sendOtp(String phone) => _source.sendPhoneOtp(phone);

  @override
  Future<void> verifyOtp({required String phone, required String token}) {
    return _source.verifyPhoneOtp(phone: phone, token: token);
  }

  @override
  Future<void> signOut() => _source.signOut();
}

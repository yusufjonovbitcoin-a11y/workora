import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthSource {
  SupabaseAuthSource(this._client);

  final SupabaseClient _client;

  Future<void> sendPhoneOtp(String phone) {
    return _client.auth.signInWithOtp(phone: phone);
  }

  Future<void> verifyPhoneOtp({
    required String phone,
    required String token,
  }) async {
    await _client.auth.verifyOTP(phone: phone, token: token, type: OtpType.sms);
  }

  Future<void> signOut() => _client.auth.signOut();
}

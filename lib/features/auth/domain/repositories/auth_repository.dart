abstract class AuthRepository {
  Future<void> sendOtp(String phone);

  Future<void> verifyOtp({required String phone, required String token});

  Future<void> signOut();
}

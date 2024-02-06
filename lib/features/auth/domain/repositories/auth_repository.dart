import 'package:sign_up_test/features/auth/data/models/app_user.dart';

abstract interface class AuthRepository {
  /// Begins auth
  Future<void> beginPhoneAuth(String phoneNumber);

  /// Verifies recieved OTP code
  Future<void> verifyOtpCode(String code);

  /// Gets current [AppUser]
  AppUser get getCurrentUser;

  /// Stream of [AppUser] objects
  Stream<AppUser> get user;
}

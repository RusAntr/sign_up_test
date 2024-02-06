import 'package:sign_up_test/features/auth/data/models/app_user.dart';

/// Defines possible auth events within BLoC
sealed class AuthEvent {
  const AuthEvent();
}

/// Sign up event
final class AppSignUpEvent extends AuthEvent {
  const AppSignUpEvent(this.phoneNumber);

  /// Phone number
  final String phoneNumber;
}

/// User's auth state changed event
final class VerifyOTPEvent extends AuthEvent {
  const VerifyOTPEvent(this.code);

  /// [AppUser] object
  final String code;
}

/// User's auth state changed event
final class AppUserChangedEvent extends AuthEvent {
  const AppUserChangedEvent(this.user);

  /// [AppUser] object
  final AppUser user;
}

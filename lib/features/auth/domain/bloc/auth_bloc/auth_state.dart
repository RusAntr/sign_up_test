import 'package:equatable/equatable.dart';
import 'package:sign_up_test/features/auth/data/models/app_user.dart';

/// Defines possible auth status
enum AuthStatus {
  authenticating,
  authenticated,
  unauthenticated,
}

/// Defines possible auth states within BLoC
final class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user = AppUser.empty,
  });

  /// Authenticated state
  const AuthState.authenticated(AppUser user)
      : this._(status: AuthStatus.authenticated, user: user);

  /// Unauthenticated state
  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  /// In process of authentication state
  const AuthState.authenticating() : this._(status: AuthStatus.authenticating);

  /// Auth status
  final AuthStatus status;

  /// [AppUser] object
  final AppUser user;

  @override
  List<Object?> get props => [status, user];
}

import 'package:sign_up_test/features/auth/data/models/app_user.dart';

abstract interface class UserRepository {
  /// Updates user info
  Future<void> update(AppUser user);

  /// Stream of [AppUser] objects
  Stream<AppUser> get user;

  /// Gets current [AppUser]
  AppUser get getCurrentUser;
}

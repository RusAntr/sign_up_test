import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sign_up_test/features/auth/data/models/app_user.dart';
import 'package:sign_up_test/features/auth/domain/repositories/user_repository.dart';

class UserCubit extends Cubit<AppUser> {
  /// User repository
  final UserRepository _userRespository;
  UserCubit(this._userRespository) : super(_userRespository.getCurrentUser);
  // @override
  // Stream<AppUser> get stream => _userRespository.user;

  /// Updates existing user
  Future<void> updateUser(AppUser newUser) async {
    emit(newUser);
    await _userRespository.update(newUser);
  }
}

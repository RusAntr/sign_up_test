import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sign_up_test/features/auth/data/models/app_user.dart';
import 'package:sign_up_test/features/auth/domain/repositories/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authenticationRepository = authRepository,
        super(
          authRepository.getCurrentUser.isNotEmpty
              ? AuthState.authenticated(authRepository.getCurrentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<AppSignUpEvent>(_beginPhoneAuthEvent);
    on<VerifyOTPEvent>(_verifyOtpEvent);
    on<AppUserChangedEvent>(_onUserChanged);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChangedEvent(user)),
    );
  }

  /// Auth repository
  final AuthRepository _authenticationRepository;

  /// Stream of [AppUser] objects
  late final StreamSubscription<AppUser> _userSubscription;

  Future<void> _beginPhoneAuthEvent(
      AppSignUpEvent event, Emitter<AuthState> emit) async {
    try {
      await _authenticationRepository.beginPhoneAuth(event.phoneNumber);
      emit(
        const AuthState.authenticating(),
      );
    } catch (e) {
      const AuthState.unauthenticated();
    }
  }

  Future<void> _verifyOtpEvent(
      VerifyOTPEvent event, Emitter<AuthState> emit) async {
    try {
      await _authenticationRepository.verifyOtpCode(event.code);
      var user = _authenticationRepository.getCurrentUser;
      _onUserChanged(AppUserChangedEvent(user), emit);
    } catch (e) {
      const AuthState.unauthenticated();
    }
  }

  void _onUserChanged(AppUserChangedEvent event, Emitter<AuthState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

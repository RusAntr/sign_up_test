import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_up_test/features/auth/data/models/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Implementation of [AuthRepository] with [FirebaseAuth]
class AuthRepositoryFirebase implements AuthRepository {
  /// Firebase auth
  final FirebaseAuth _firebaseAuth;
  AuthRepositoryFirebase(this._firebaseAuth);
  late String _verificationId;

  /// Begins phone auth
  @override
  Future<void> beginPhoneAuth(String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException exception) =>
            throw Exception(exception.message),
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String codeAutoRetrievalTimeout) {},
        timeout: const Duration(seconds: 60),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Verifies OTP code and signs user in
  @override
  Future<void> verifyOtpCode(String code) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: code,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Returns the current user if they are signed in
  @override
  AppUser get getCurrentUser {
    try {
      final user = _firebaseAuth.currentUser == null
          ? AppUser.empty
          : _firebaseAuth.currentUser!.toUser;
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Notifies about changes to user's auth state
  @override
  Stream<AppUser> get user {
    try {
      return _firebaseAuth.authStateChanges().map((firebaseUser) {
        final user = firebaseUser == null ? AppUser.empty : firebaseUser.toUser;
        return user;
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}

extension on User {
  /// Maps a firebase [User] into an [AppUser].
  AppUser get toUser {
    return AppUser(
      id: uid,
      phoneNumber: phoneNumber,
      name: displayName,
      photo: photoURL,
    );
  }
}

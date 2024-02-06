import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_up_test/features/auth/data/models/app_user.dart';
import 'package:sign_up_test/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryFirebase implements UserRepository {
  UserRepositoryFirebase(this._firestore, this._firebaseAuth);

  /// Firebase
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  /// Updates user info
  @override
  Future<void> update(AppUser newUser) async {
    try {
      bool exists = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .get()
          .then((value) => value.exists);
      if (exists) {
        await _firestore
            .collection('users')
            .doc(_firebaseAuth.currentUser?.uid)
            .update(newUser.toJson());
        return;
      }
      _create(newUser);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Creates new user
  Future<void> _create(AppUser user) async {
    try {
      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .set(
            user.toJson(),
          );
    } on FirebaseException catch (e) {
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
      return _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .snapshots()
          .map((event) => AppUser.fromDocument(event));
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

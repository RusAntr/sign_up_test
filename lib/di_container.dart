import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_up_test/features/auth/data/repositories/auth_repository_firebase.dart';
import 'package:sign_up_test/features/auth/data/repositories/storage_repository_firebase.dart';
import 'package:sign_up_test/features/auth/data/repositories/user_repository_firebase.dart';
import 'package:sign_up_test/features/auth/domain/bloc/user_cubit/user_cubit.dart';
import 'package:sign_up_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:sign_up_test/features/auth/domain/repositories/storage_repositoty.dart';
import 'package:sign_up_test/features/auth/domain/repositories/user_repository.dart';

import 'features/auth/domain/bloc/auth_bloc/bloc.dart';

/// Dependency injection container
class DIContainer {
  DIContainer._();

  /// Making DI Container a singleton
  static final _instance = DIContainer._();

  /// Singleton instance
  static DIContainer get instance => _instance;

  /// Closes BloC's and cubit's streams
  void dispose() async {
    await authBloc.close();
    await userCubit.close();
  }

  /// Firebase
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;

  /// Image picker
  ImagePicker get _imagePicker => ImagePicker();

  /// Repositories
  late final AuthRepository authRepository;
  late final UserRepository userRepository;
  StorageRepositoty get storageRepository => StorageRepositoryFirebase(
        _firebaseStorage,
        _imagePicker,
      );

  /// BloCs
  late final AuthBloc authBloc;
  late final UserCubit userCubit;

  Future<void> init() async {
    authRepository = AuthRepositoryFirebase(_firebaseAuth);
    userRepository = UserRepositoryFirebase(_firebaseFirestore, _firebaseAuth);

    authBloc = AuthBloc(authRepository: authRepository);
    userCubit = UserCubit(userRepository);
  }
}

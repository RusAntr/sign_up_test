import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_up_test/features/auth/domain/repositories/storage_repositoty.dart';

/// Implementation of [StorageRepositoty] with Firebase Storage
class StorageRepositoryFirebase implements StorageRepositoty {
  final FirebaseStorage _firebaseStorage;
  final ImagePicker _imagePicker;
  StorageRepositoryFirebase(
    this._firebaseStorage,
    this._imagePicker,
  );

  /// Uploads photo to Firebase storage, returns link
  @override
  Future<String?> uploadPhoto(ImageSource source) async {
    try {
      var image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        var file = File(image.path);
        var snapshot =
            await _firebaseStorage.ref().child('images/avatar').putFile(file);
        return await snapshot.ref.getDownloadURL();
      }
      return null;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }
}

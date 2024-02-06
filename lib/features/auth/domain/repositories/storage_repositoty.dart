import 'package:image_picker/image_picker.dart';

abstract interface class StorageRepositoty {
  Future<String?> uploadPhoto(ImageSource source);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.g.dart';
part 'app_user.freezed.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    String? id,
    String? name,
    String? lastName,
    String? phoneNumber,
    String? photo,
  }) = _AppUser;

  /// Private empty constructor
  const AppUser._();

  /// User from JSON object
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  /// Empty user
  static const empty = AppUser(id: '');

  /// User from [DocumentSnapshot] object (Firebase)
  factory AppUser.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();
    if (data != null) {
      return AppUser.fromJson(data as Map<String, dynamic>)
          .copyWith(id: doc.id);
    }
    return empty;
  }

  /// Whether the current user is empty.
  bool get isEmpty => this == AppUser.empty;

  /// Whether the current user is not empty.
  bool get isNotEmpty => this != AppUser.empty;
}

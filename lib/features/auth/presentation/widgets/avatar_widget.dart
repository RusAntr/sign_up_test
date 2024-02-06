import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_up_test/config/sign_up_test_app_icons.dart';
import 'package:sign_up_test/di_container.dart';
import 'package:sign_up_test/features/auth/data/models/app_user.dart';
import 'package:sign_up_test/features/auth/domain/bloc/user_cubit/user_cubit.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  /// Calls repository to upload a photo and cubit to update user
  Future<void> _pickAndUpload(ImageSource source, BuildContext context) async {
    var userCubit = context.read<UserCubit>();
    var storageRepo = DIContainer.instance.storageRepository;
    var url = await storageRepo.uploadPhoto(source);
    if (url != null) {
      userCubit.updateUser(userCubit.state.copyWith(photo: url));
    }
  }

  Widget _avatar(BuildContext context) {
    var photo = context.read<UserCubit>().state.photo;
    if (photo != null && photo.isNotEmpty) {
      return Image.network(
        photo,
        width: 80,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) => Icon(
          SignUpTestAppIcons.person,
          size: 65,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      );
    }
    return Icon(
      SignUpTestAppIcons.person,
      size: 65,
      color: Theme.of(context).colorScheme.onSecondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      radius: 40,
      child: ClipOval(
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, 0),
              child: BlocBuilder<UserCubit, AppUser>(
                  bloc: context.watch<UserCubit>(),
                  builder: (context, state) => _avatar(context)),
            ),
            Align(
              alignment: const Alignment(1, 0.8),
              child: GestureDetector(
                onTap: () => showCupertinoModalPopup(
                    context: context,
                    builder: (modalContext) {
                      return CupertinoActionSheet(
                        title: const Text('Выберете фото'),
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              await _pickAndUpload(ImageSource.camera, context)
                                  .whenComplete(() => Navigator.pop(context));
                            },
                            child: Text(
                              'Камера',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              await _pickAndUpload(ImageSource.gallery, context)
                                  .whenComplete(() => Navigator.pop(context));
                            },
                            child: Text(
                              'Галерея Фото',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                            ),
                          ),
                        ],
                      );
                    }),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: GestureDetector(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Generates dots
                          ...List.generate(
                            3,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              child: Icon(
                                Icons.circle,
                                size: 6,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

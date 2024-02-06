import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up_test/di_container.dart';
import 'package:sign_up_test/features/auth/data/models/app_user.dart';
import 'package:sign_up_test/features/auth/domain/bloc/user_cubit/user_cubit.dart';
import 'package:sign_up_test/features/auth/presentation/screens/home/change_field_screen.dart';
import 'package:sign_up_test/features/auth/presentation/widgets/avatar_widget.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  void _goToEditScreen(EditType editType, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider<UserCubit>.value(
          value: DIContainer.instance.userCubit,
          child: ChangeFieldScreen(
            editType: editType,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        automaticallyImplyLeading: false,
        title: const Text('Аккаунт'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserCubit, AppUser>(
        bloc: context.read<UserCubit>(),
        builder: (context, state) {
          return ListView(
            children: [
              /// Divider
              Divider(
                thickness: 0.6,
                height: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),

              /// Avatar widget
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Center(
                  child: BlocProvider.value(
                    value: DIContainer.instance.userCubit,
                    child: const AvatarWidget(),
                  ),
                ),
              ),

              /// Email
              Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 12),
                child: Text(
                  'apollon@gmail.com',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),

              /// User parameters settings
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child:

                          /// Name
                          GestureDetector(
                        onTap: () => _goToEditScreen(EditType.name, context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Имя',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Row(
                              children: [
                                Text(
                                  state.name ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.6,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child:

                          /// Last name
                          GestureDetector(
                        onTap: () =>
                            _goToEditScreen(EditType.lastName, context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Фамилия',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Row(
                              children: [
                                Text(
                                  state.lastName ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.6,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

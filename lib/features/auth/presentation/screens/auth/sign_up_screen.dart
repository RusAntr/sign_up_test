import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up_test/di_container.dart';
import 'package:sign_up_test/features/auth/domain/bloc/user_cubit/user_cubit.dart';
import 'package:sign_up_test/features/auth/presentation/screens/home/main_screen.dart';
import 'package:sign_up_test/features/auth/presentation/widgets/stepper_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  /// Text editing controller
  late final _nameEditingController = TextEditingController();
  late final _lastNameEditingController = TextEditingController();

  /// Whether name and last name are enterd
  bool get _areFieldsNotEmpty =>
      _nameEditingController.text.isNotEmpty &&
      _lastNameEditingController.text.isNotEmpty;

  /// Updates user
  void _updateUser() async {
    var userCubit = context.read<UserCubit>();
    await userCubit
        .updateUser(
          userCubit.state.copyWith(
            name: _nameEditingController.text,
            lastName: _lastNameEditingController.text,
          ),
        )

        /// Navigates user to main screen after update completion
        .whenComplete(
          () async => await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: DIContainer.instance.userCubit,
                child: const MainScreen(),
              ),
            ),
          ),
        );
  }

  /// Disposes text editing controllers
  @override
  void dispose() {
    super.dispose();
    _nameEditingController.dispose();
    _lastNameEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            /// Stepper
            const StepperWidget(currentStep: 3),

            /// Title text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'Регистрация',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),

            /// Text above form field
            Padding(
              padding: const EdgeInsets.only(top: 38.0, bottom: 4),
              child: Text(
                'Имя',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),

            /// Name text form field
            TextFormField(
              controller: _nameEditingController,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 17),
            ),

            /// Text above form field
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
              child: Text(
                'Фамилия',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),

            /// Last name text form field
            TextFormField(
              controller: _lastNameEditingController,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 17),
            ),

            /// Save button
            ListenableBuilder(
              listenable: _lastNameEditingController,
              builder: (context, child) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24.0, horizontal: 50),
                child: ElevatedButton(
                  onPressed: () {
                    if (_areFieldsNotEmpty) {
                      _updateUser();
                    }
                  },
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: !_areFieldsNotEmpty
                            ? MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.secondary)
                            : MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.primary),
                      ),
                  child: Text(
                    'Сохранить',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

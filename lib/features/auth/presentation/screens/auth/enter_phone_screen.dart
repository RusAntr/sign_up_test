import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up_test/core/utils/phone_input_formatter.dart';
import 'package:sign_up_test/di_container.dart';
import 'package:sign_up_test/features/auth/domain/bloc/auth_bloc/bloc.dart';
import 'package:sign_up_test/features/auth/presentation/screens/auth/verify_otp_screen.dart';
import 'package:sign_up_test/features/auth/presentation/widgets/stepper_widget.dart';

class EnterPhoneScreen extends StatefulWidget {
  const EnterPhoneScreen({super.key});

  @override
  State<EnterPhoneScreen> createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  /// Text edititng controller
  late final _editingController = TextEditingController();

  /// Whether the phone number is complete
  bool get _isPhoneNumComplete => _editingController.text.length > 17;
  @override
  void dispose() {
    super.dispose();
    _editingController.dispose();
  }

  /// Calls bloc to add [AppSignUpEvent]
  void _onPress(String phoneNumber) async {
    AuthBloc bloc = context.read<AuthBloc>();
    bloc.add(AppSignUpEvent(phoneNumber));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      /// Listens to [AuthState] and navigates user if the state == authenticating
      child: BlocListener(
        bloc: context.read<AuthBloc>(),
        listener: (context, AuthState state) async {
          if (state.status == AuthStatus.authenticating) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => DIContainer.instance.authBloc,
                  child: VerifyOtpScreen(
                    phoneNumber: _editingController.text,
                  ),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              /// Stepper
              const StepperWidget(currentStep: 1),

              /// Title text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  'Регистрация',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),

              /// Subtitle text
              Text(
                'Введите номер телефона\nдля регистрации',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),

              /// Text above form field
              Padding(
                padding: const EdgeInsets.only(top: 38.0, bottom: 4),
                child: Text(
                  'Номер телефона',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),

              /// Phone number text form field
              TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 17),
                controller: _editingController,
                inputFormatters: [PhoneInputFormatter()],
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  // setState(() {});
                },
              ),

              /// Send sms button
              ListenableBuilder(
                listenable: _editingController,
                builder: (context, _) => Padding(
                  padding: const EdgeInsets.fromLTRB(30, 100, 30, 8),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isPhoneNumComplete) {
                        _onPress(_editingController.text);
                      }
                    },
                    style:
                        Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              backgroundColor: !_isPhoneNumComplete
                                  ? MaterialStatePropertyAll(
                                      Theme.of(context).colorScheme.secondary)
                                  : MaterialStatePropertyAll(
                                      Theme.of(context).colorScheme.primary),
                            ),
                    child: Text(
                      'Отправить смс-код',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              ),

              /// Personal info text
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'Нажимая на данную кнопку, вы даете\n согласие на обработку',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: ' персональных данных',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

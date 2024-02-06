import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:sign_up_test/di_container.dart';
import 'package:sign_up_test/features/auth/domain/bloc/auth_bloc/bloc.dart';
import 'package:sign_up_test/features/auth/presentation/widgets/stepper_widget.dart';

import 'sign_up_screen.dart';

/// OTP verification screen
class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  /// OTP text contoller
  late final _editingController = TextEditingController();

  /// Auth bloc
  late final _bloc = context.read<AuthBloc>();

  /// Seconds until timer cancels
  int _seconds = 60;

  /// Timer
  late Timer _timer;

  /// Starts timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
      });
      if (_seconds == 0) {
        timer.cancel();
        _seconds = 60;
      }
    });
  }

  /// Resends code or restarts timer based on [_timer] activity
  void _resendCode() {
    _bloc.add(AppSignUpEvent(widget.phoneNumber));
    if (_timer.isActive) {
    } else {
      _startTimer();
    }
  }

  /// Adds [VerifyOTPEvent] when OTP is fully entered in pinput field
  void _onOTPComplete(String code) {
    _bloc.add(VerifyOTPEvent(code));
  }

  /// Starts timer right after initializing
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  /// Disposes timer and text editing controller
  @override
  void dispose() {
    super.dispose();
    _editingController.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener(
        bloc: _bloc,
        listener: (context, AuthState state) async {
          /// Listens to [AuthState] and navigates user if the state is authenticated
          if (state.status == AuthStatus.authenticated) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: DIContainer.instance.userCubit,
                  child: const SignUpScreen(),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          body: ListView(
            children: [
              /// Stepper
              const StepperWidget(currentStep: 2),

              /// Title text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Подтверждение',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              /// Subtitle text
              Text(
                'Введите код, который мы отправили\n в SMS на ${widget.phoneNumber}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              /// OTP input field
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 38, 40, 64),
                child: Pinput(
                  controller: _editingController,
                  length: 6,
                  onCompleted: (value) =>
                      _onOTPComplete(_editingController.text),
                  defaultPinTheme: PinTheme(
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 2,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ),
              ),

              /// Resend code  text
              GestureDetector(
                onTap: () => _resendCode(),
                child: Text(
                  textAlign: TextAlign.center,
                  _timer.isActive
                      ? '$_seconds сек до повтора отправки кода'
                      : 'Отправить код еще раз',
                  style: _timer.isActive
                      ? Theme.of(context).textTheme.bodyLarge
                      : Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

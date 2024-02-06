import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up_test/config/themes/app_themes.dart';
import 'package:sign_up_test/di_container.dart';
import 'package:sign_up_test/firebase_options.dart';

import 'features/auth/presentation/screens/auth/enter_phone_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DIContainer.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign up app demo',
      theme: AppThemes.defaultTheme,
      home: BlocProvider(
        create: (context) => DIContainer.instance.authBloc,
        child: const EnterPhoneScreen(),
      ),
    );
  }
}

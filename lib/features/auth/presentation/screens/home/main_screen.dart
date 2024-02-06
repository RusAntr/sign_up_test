import 'package:flutter/material.dart';
import 'package:sign_up_test/config/sign_up_test_app_icons.dart';
import 'package:sign_up_test/features/auth/presentation/screens/home/account_settings_screen.dart';
import 'package:sign_up_test/features/auth/presentation/screens/home/projects_screen.dart';

/// Contains bottom navigation bar
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  final List _pages = const [ProjectsScreen(), AccountSettingsScreen()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_currentPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          elevation: 5,
          selectedItemColor: Theme.of(context).colorScheme.onSecondary,
          onTap: (value) => setState(() {
            _currentPageIndex = value;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(SignUpTestAppIcons.projects),
              label: 'Мои проекты',
            ),
            BottomNavigationBarItem(
              icon: Icon(SignUpTestAppIcons.person),
              label: 'Мой аккаунт',
            ),
          ],
        ),
      ),
    );
  }
}

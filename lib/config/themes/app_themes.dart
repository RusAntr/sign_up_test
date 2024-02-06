import 'package:flutter/material.dart';

/// App themes
class AppThemes {
  /// Colors used in the app
  static const primaryColor = Color(0xffFFB800);
  static const onPrimaryColor = Color(0xff4F4F4F);

  static const backgroundColor = Color(0xffFBFBFB);
  static const onBackgroundColor = Color(0xffE3E3E3);

  static const secondaryColor = Color(0xffA7A7A7);
  static const onSecondaryColor = Color(0xff0098EE);

  static const surfaceColor = Color(0xff39A314);
  static const onSurfaceColor = Color(0xff7D7D7D);

  /// Colors related to errors
  static const errorColor = Color(0xffEB5757);
  static const onErrorColor = Color(0xffD9D9D9);

  /// Colors related to text
  static const primaryTextColor = Color(0xff4F4F4F);
  static const secondaryTextColor = Color(0xff0098EE);
  static const extraTextColor = Color(0xff2C3035);

  /// Default light theme
  static ThemeData defaultTheme = ThemeData(
    brightness: Brightness.light,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    textTheme: textTheme,
    fontFamily: '.SF UI Text',

    /// Scheme of colors for this theme
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: secondaryColor,
      primaryContainer: Color(0xffF6F6F6),
      secondaryContainer: Color(0xffC6C6C8),
      onSecondary: onSecondaryColor,
      error: errorColor,
      errorContainer: Color(0xffECECEC),
      onError: onErrorColor,
      background: backgroundColor,
      onBackground: onBackgroundColor,
      surface: surfaceColor,
      onSurface: onSurfaceColor,
    ),

    /// Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          textTheme.bodyLarge,
        ),
        backgroundColor: MaterialStateProperty.all(primaryColor),
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(
          const Size(500, 53),
        ),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    ),

    /// App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: onBackgroundColor,
      actionsIconTheme: const IconThemeData(
        size: 32,
        color: primaryTextColor,
      ),
      titleTextStyle: textTheme.displaySmall,
    ),

    /// TextField decoration
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: primaryColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: onErrorColor,
        ),
      ),
    ),
  );

  /// App's text theme
  static const textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w500,
      color: primaryTextColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      color: primaryTextColor,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: primaryTextColor,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: primaryTextColor,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: primaryTextColor,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: primaryTextColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: primaryTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: secondaryColor,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: secondaryTextColor,
    ),
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: primaryTextColor,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: secondaryTextColor,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: secondaryTextColor,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primary = Color(0xFFFF3C3C);
  static const background = Color(0xFFFFFFFF);
  static const borderColor = Color(0x883D3B3B);
  static const cardColor = Color(0xFFF2ECEC);
  static const bubbleColors = [
    Color.fromRGBO(255, 60, 60, 0.5),
    Color.fromRGBO(255, 60, 60, 0),
  ];
  static ThemeData theme(TextTheme textTheme) => ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        chipTheme: ChipThemeData(
          shape: const StadiumBorder(),
          color: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return AppTheme.primary;
              } else {
                return AppTheme.background;
              }
            },
          ),
          showCheckmark: false,
          labelStyle: const TextStyle(color: Colors.black),
          secondaryLabelStyle: const TextStyle(color: Colors.white),
          side: const BorderSide(color: AppTheme.primary),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF454545),
          ),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            iconTheme: IconThemeData(color: Colors.white)),
        textTheme: GoogleFonts.poppinsTextTheme(textTheme).copyWith(
          titleLarge: textTheme.headlineLarge?.copyWith(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: AppTheme.primary,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
            side: const BorderSide(
              color: AppTheme.primary,
              width: 1.5,
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/variables.dart';

import '../constants/colors.dart';

class GorillaTheme {
  static final ThemeData lightGorillaTheme = ThemeData.light().copyWith(
      popupMenuTheme: PopupMenuThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle: tStylePopUpMenu,
          color: tColorBottomSheetG),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: tColorPrimary,
          fontSize: 62,
          fontFamily: outfit,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
            color: Color(0xFF6C6AB8),
            fontSize: 20,
            fontFamily: 'Roboto_condensed',
            fontWeight: FontWeight.w700),
        // displaySmall:,
        // headlineLarge:,
        headlineMedium: TextStyle(fontFamily: 'Roboto_condensed'),
        headlineSmall: TextStyle(color: tColorBlacky),
        titleLarge: TextStyle(color: tColorBlacky),
        titleMedium: TextStyle(color: tColorBlacky),
        titleSmall: TextStyle(color: tColorBlacky),
        bodyLarge: TextStyle(color: tColorBlacky),
        bodyMedium: TextStyle(color: tColorBlacky),
        bodySmall: TextStyle(color: tColorBlacky),
        //  labelLarge:,
        //  labelMedium:,
        //  labelSmall:,
      ),
      //scaffoldBackgroundColor: tBlack,
      colorScheme: const ColorScheme(
          background: tColorWhite,
          brightness: Brightness.light,
          primary: tColorPinky,
          onPrimary: tColorPrimaryLighter,
          secondary: tColorPrimaryLighter,
          onSecondary: tColorPrimaryLighter,
          error: tColorPink,
          onError: tColorPink,
          onBackground: tColorPink,
          surface: tColorPink,
          onSurface: tColorBlacky));
}

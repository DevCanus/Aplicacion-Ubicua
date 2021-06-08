import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// COLOR DEFINITION
const primary = const Color(0xff82b1ff);
const primaryLight = const Color(0xffb6e3ff);
const primaryDark = const Color(0xff4d82cb);
const secondary = const Color(0xffb29ddb);
const secondaryLight = const Color(0xffe5ceff);
const secondaryDark = const Color(0xff826fa9);
const textColor = const Color(0xff000000);
const background = const Color(0xffeceff1);

class MyTheme {
  static final ThemeData defaultTheme = _buildMyTheme();

  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      accentColor: secondary,
      accentColorBrightness: Brightness.dark,

      primaryColor: primary,
      primaryColorDark: primaryDark,
      primaryColorLight: primaryLight,
      primaryColorBrightness: Brightness.dark,

      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: secondary,
        textTheme: ButtonTextTheme.primary,
      ),

      secondaryHeaderColor: secondary,

      scaffoldBackgroundColor: background,
      textSelectionColor: primaryLight,
      backgroundColor: background,
      cardColor: background,

      textTheme: base.textTheme.copyWith(
          headline6: base.textTheme.headline6.copyWith(color: textColor),
          bodyText2: base.textTheme.bodyText2.copyWith(color: textColor),
          bodyText1: base.textTheme.bodyText1.copyWith(color: textColor)
      ),
    );
  }
}
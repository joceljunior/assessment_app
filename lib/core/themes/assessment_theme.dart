import 'package:flutter/material.dart';

enum AssessmentThemeKeys { saborTrigo, skinaPao, defaultTheme }

class AssessmentTheme {
  static final ThemeData defaultTheme = ThemeData(
    primaryColor: Colors.blue,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          side: MaterialStateProperty.all(
            BorderSide(
              width: 1,
              color: Color.fromARGB(78, 0, 0, 0),
            ),
          )),
    ),
    fontFamily: 'ProductSans',
  );

  static final ThemeData saborTrigoTheme = ThemeData(
    primaryColor: Color.fromRGBO(247, 138, 53, 1),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor:
              MaterialStateProperty.all(Color.fromRGBO(247, 138, 53, 1)),
          side: MaterialStateProperty.all(
            BorderSide(
              width: 1,
              color: Color.fromARGB(78, 0, 0, 0),
            ),
          )),
    ),
    fontFamily: 'ProductSans',
  );

  static final ThemeData skinaPaoTheme = ThemeData(
    primaryColor: Color.fromRGBO(150, 6, 6, 1),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor:
              MaterialStateProperty.all(Color.fromRGBO(150, 6, 6, 1)),
          side: MaterialStateProperty.all(
            BorderSide(
              width: 1,
              color: Color.fromARGB(78, 0, 0, 0),
            ),
          )),
    ),
    fontFamily: 'ProductSans',
  );

  static ThemeData getThemeFromKey(AssessmentThemeKeys themeKey) {
    switch (themeKey) {
      case AssessmentThemeKeys.saborTrigo:
        return saborTrigoTheme;
      case AssessmentThemeKeys.skinaPao:
        return skinaPaoTheme;
      default:
        return defaultTheme;
    }
  }
}

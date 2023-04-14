import 'package:flutter/material.dart';

import '../core/themes/assessment_theme.dart';

class AppStore extends ValueNotifier<ThemeData> {
  AppStore() : super(AssessmentTheme.defaultTheme);

  void changeTheme({required AssessmentThemeKeys key}) {
    switch (key) {
      case AssessmentThemeKeys.saborTrigo:
        value = AssessmentTheme.saborTrigoTheme;
        break;
      case AssessmentThemeKeys.skinaPao:
        value = AssessmentTheme.skinaPaoTheme;
        break;
      default:
        value = AssessmentTheme.defaultTheme;
    }
  }
}

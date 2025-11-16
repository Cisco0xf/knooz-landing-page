import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knooz_docs_api/constants/colors.dart';

class ThemeSwitcher extends Notifier<bool> {
  @override
  bool build() => true;

  void switchTheme(bool mode) {
    state = mode;
    _switchColors();
  }

  Brightness get appBrightness {
    if (state) {
      return Brightness.dark;
    }

    return Brightness.light;
  }

  void _switchColors() {
    if (state) {
      SwitchColors.backgroundColor = DarkColors.backgroundColor;
      SwitchColors.secondaryColor = DarkColors.secondaryColor;
      SwitchColors.primaryColor = DarkColors.primaryColor;
      SwitchColors.accentColor = DarkColors.accentColor;
      SwitchColors.borderColor = DarkColors.borderColor;
      SwitchColors.textColor = DarkColors.textColor;
    } else {
      SwitchColors.backgroundColor = LightColors.backgroundColor;
      SwitchColors.secondaryColor = LightColors.secondaryColor;
      SwitchColors.primaryColor = LightColors.primaryColor;
      SwitchColors.accentColor = LightColors.accentColor;
      SwitchColors.borderColor = LightColors.borderColor;
      SwitchColors.textColor = LightColors.textColor;
    }
  }
}

final themeProvider = NotifierProvider<ThemeSwitcher, bool>(
  ThemeSwitcher.new,
);

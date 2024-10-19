import 'package:flutter/cupertino.dart';
import 'package:xlfz/styles/index.dart';

class AppStyle {
  final BuildContext context;

  AppStyle(this.context);

  bool get isDarkMode {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  Color get primaryColor =>
      isDarkMode ? AppColors.darkPrimaryColor : AppColors.lightPrimaryColor;

  Color get backgroundColor => isDarkMode
      ? AppColors.darkBackgroundColor
      : AppColors.lightBackgroundColor;

  Color get cardBackgroundColor => isDarkMode
      ? AppColors.darkCardBackgroundColor
      : AppColors.lightCardBackgroundColor;

  Color get accentColor =>
      isDarkMode ? AppColors.darkAccentColor : AppColors.lightAccentColor;

  Color get textColor =>
      isDarkMode ? AppColors.darkTextColor : AppColors.lightTextColor;

  Color get contentColor =>
      isDarkMode ? AppColors.darkContentColor : AppColors.lightContentColor;
}

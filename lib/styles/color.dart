import 'package:flutter/cupertino.dart';
import 'package:xlfz/styles/index.dart';

class AppStyle {
  final BuildContext context;

  AppStyle(this.context);

  bool get isDarkMode {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  Color _getColor(Color darkColor, Color lightColor) =>
      isDarkMode ? darkColor : lightColor;

  Color get primaryColor =>
      _getColor(AppColors.darkPrimaryColor, AppColors.lightPrimaryColor);

  Color get backgroundColor =>
      _getColor(AppColors.darkBackgroundColor, AppColors.lightBackgroundColor);

  Color get cardBackgroundColor => _getColor(
      AppColors.darkCardBackgroundColor, AppColors.lightCardBackgroundColor);

  Color get accentColor =>
      _getColor(AppColors.darkAccentColor, AppColors.lightAccentColor);

  Color get textColor =>
      _getColor(AppColors.darkTextColor, AppColors.lightTextColor);

  Color get contentColor =>
      _getColor(AppColors.darkContentColor, AppColors.lightContentColor);

  Color get dividerColor =>
      _getColor(AppColors.darkDividerColor, AppColors.lightDividerColor);
}

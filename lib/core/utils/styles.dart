import 'package:flutter/material.dart';
import 'package:tako/core/constants/constants.dart';
import 'package:tako/core/utils/app_colors.dart';

TextStyle getHeadTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color ?? AppColors.primaryColor,
    fontSize: fontSize ?? 30,
  );
}

TextStyle getTitleTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color ?? AppColors.primaryColor,
    fontSize: fontSize ?? 25,
  );
}

TextStyle getBodyTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color ?? AppColors.primaryColor,
    fontSize: fontSize ?? 18,
  );
}

TextStyle getSmallTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color ?? AppColors.primaryColor,
    fontSize: fontSize ?? 15,
  );
}
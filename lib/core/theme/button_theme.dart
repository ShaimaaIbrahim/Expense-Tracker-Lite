

import 'package:expense_tracker_lite/core/constants/app_colors.dart';
import 'package:flutter/material.dart';


ButtonThemeData buttonTheme = ButtonThemeData(
  height: 90,
  buttonColor:AppColors.primaryColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  textTheme: ButtonTextTheme.primary,
);

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor:AppColors.primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
);

FloatingActionButtonThemeData floatingActionButtonThemeData =
    const FloatingActionButtonThemeData(
  backgroundColor:AppColors.primaryColor,
  splashColor: Colors.grey,
);

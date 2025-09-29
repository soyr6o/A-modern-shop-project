import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MElevatedButtonTheme {
  MElevatedButtonTheme._();



  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: MColors.light,
      backgroundColor: MColors.primary,
      disabledForegroundColor: MColors.darkGrey,
      disabledBackgroundColor: MColors.buttonDisabled,
      side: const BorderSide(color: MColors.light),
      padding: const EdgeInsets.symmetric(vertical: MSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: MColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MSizes.buttonRadius)),
    ),
  );


  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: MColors.light,
      backgroundColor: MColors.primary,
      disabledForegroundColor: MColors.darkGrey,
      disabledBackgroundColor: MColors.darkerGrey,
      side: const BorderSide(color: MColors.primary),
      padding: const EdgeInsets.symmetric(vertical: MSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: MColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MSizes.buttonRadius)),
    ),
  );
}
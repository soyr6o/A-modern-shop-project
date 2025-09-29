import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class MOutlinedButtonTheme {
  MOutlinedButtonTheme._();


  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: MColors.dark,
      side: const BorderSide(color: MColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: MColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: MSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MSizes.buttonRadius)),
    ),
  );


  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: MColors.light,
      side: const BorderSide(color: MColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: MColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: MSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MSizes.buttonRadius)),
    ),
  );
}
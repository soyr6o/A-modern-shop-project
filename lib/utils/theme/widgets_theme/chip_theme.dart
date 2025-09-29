import 'package:appwrite2/utils/constants/color.dart';
import 'package:flutter/material.dart';

class MChipTheme{

  // private constructor
  MChipTheme._();


  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: MColors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: MColors.black),
    selectedColor: MColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: MColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: MColors.darkerGrey,
    labelStyle: TextStyle(color: MColors.white),
    selectedColor: MColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: MColors.white,
  );
}
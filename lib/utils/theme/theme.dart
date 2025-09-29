import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/theme/widgets_theme/appbar_theme.dart';
import 'package:appwrite2/utils/theme/widgets_theme/bottom_sheet_theme.dart';
import 'package:appwrite2/utils/theme/widgets_theme/checkbox_theme.dart';
import 'package:appwrite2/utils/theme/widgets_theme/chip_theme.dart';
import 'package:appwrite2/utils/theme/widgets_theme/elevated_bottom_theme.dart';
import 'package:appwrite2/utils/theme/widgets_theme/outlined_button_theme.dart';
import 'package:appwrite2/utils/theme/widgets_theme/text_filed_theme.dart';
import 'package:flutter/material.dart';
import 'widgets_theme/text_theme.dart';

class MAppTheme {
  // private constructor
  MAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    primaryColor: MColors.primary,
    disabledColor: MColors.grey,
    textTheme: MTextTheme.lightTextTheme,
    chipTheme: MChipTheme.lightChipTheme,
    scaffoldBackgroundColor: MColors.white,
    appBarTheme: MAppBarTheme.lightAppBarTheme,
    checkboxTheme: MCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: MElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    primaryColor: MColors.primary,
    disabledColor: MColors.grey,
    textTheme: MTextTheme.darkTextTheme,
    chipTheme: MChipTheme.darkChipTheme,
    scaffoldBackgroundColor: MColors.black,
    appBarTheme: MAppBarTheme.darkAppBarTheme,
    checkboxTheme: MCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: MBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: MElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: MOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MTextFormFieldTheme.darkInputDecorationTheme,
  );
}

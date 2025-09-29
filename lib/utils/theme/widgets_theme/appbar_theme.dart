import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class MAppBarTheme{
  MAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: MColors.black, size: MSizes.iconMd),
    actionsIconTheme: IconThemeData(color: MColors.black, size: MSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: MColors.black),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: MColors.white, size: MSizes.iconMd),
    actionsIconTheme: IconThemeData(color: MColors.white, size: MSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: MColors.white),
  );
}
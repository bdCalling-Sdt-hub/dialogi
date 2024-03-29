import 'package:dialogi_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceUtils{
  static void allScreenUtils(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:AppColors.background,
          statusBarColor:AppColors.background,
          systemStatusBarContrastEnforced: true,
          systemNavigationBarDividerColor: Colors.transparent,
        )
    );
  }
}
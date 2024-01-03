import 'package:dialogi_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color? borderColor;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;

  const CustomElevatedButton(
      {required this.onPressed,
      required this.titleText,
      this.titleColor = Colors.white,
      this.buttonColor = AppColors.black_500,
      this.titleSize = 18,
      this.buttonRadius = 8,
      this.titleWeight = FontWeight.w600,
      this.buttonHeight = 58,
      this.buttonWidth,
      this.borderColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight.h,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
                side: BorderSide(
                    color: borderColor ?? Colors.transparent, width: 1.0),
              ),
            ),
            elevation: MaterialStateProperty.all(0)),
        child: Text(
          titleText,
          textAlign: TextAlign.center,
          style: GoogleFonts.prompt(
              color: titleColor,
              fontSize: titleSize.sp,
              fontWeight: titleWeight),
        ),
      ),
    );
  }
}

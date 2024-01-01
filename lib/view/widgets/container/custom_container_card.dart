import 'package:dialogi_app/utils/app_colors.dart';
import 'package:flutter/material.dart';


class CustomContainerCard extends StatelessWidget {
  const  CustomContainerCard(
      {super.key,
        this.marginBottom=0,
        this.paddingTop=0,
        this.paddingLeft=0,
        this.paddingRight=0,
        this.marginLeft=0,
        this.marginRight=0,
        this.marginTop=0,
        this.paddingBottom=0,
        required this.content,
        this.onTap,
        this.decoration,
        this.width,
        this.height,
        this.alignment
      });
  final Widget? content;
  final double paddingBottom;
  final double paddingTop;
  final double paddingLeft;
  final double paddingRight;
  final double marginBottom;
  final double marginTop;
  final double marginLeft;
  final double marginRight;
  final double ? width;
  final double ? height;
  final VoidCallback ?onTap;
  final Decoration ? decoration;
  final Alignment ?alignment;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal:20),
        margin:  EdgeInsets.only(bottom: marginBottom, top: marginTop, left: marginLeft, right: marginRight),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.gray_900,
          // border: Border.all(color: AppColors.primaryColor,width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child:content,
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidy_bayti/utils/app_colors.dart';
import 'package:tidy_bayti/utils/app_icons.dart';
import 'package:tidy_bayti/view/widgets/image/custom_image.dart';
import 'package:tidy_bayti/view/widgets/text/custom_text.dart';

class CustomSchedule extends StatefulWidget {
  final String scheduleText;
  final double width;
  final double bottomPadding;
  final double topPadding;
  final double rightPadding;
  final double leftPadding;
  final Widget content;
  CustomSchedule(
      {super.key,
      required this.scheduleText,
      required this.content,
      this.width = 0,
        this.bottomPadding=0,
        this.leftPadding=0,
        this.rightPadding=0,
        this.topPadding=0
      });

  @override
  State<CustomSchedule> createState() => _CustomScheduleState();
}

class _CustomScheduleState extends State<CustomSchedule> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isClicked = !isClicked;
            });
          },
          child: Container(
            padding: EdgeInsets.only(
              bottom:widget.bottomPadding,
              top:widget.topPadding,
              right:widget.rightPadding,
              left: widget.leftPadding,
            ),
            width: widget.width,
            decoration: BoxDecoration(
              color: AppColors.container,
              border: Border.all(color: AppColors.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: widget.scheduleText,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.h,
                  color: AppColors.secondaryColor,
                ),
              isClicked
                        ? CustomImage(
                            imageSrc: AppIcons.chevronUp,
                            imageType: ImageType.svg,
                            size: 24.h,
                          )
                        : CustomImage(
                            imageSrc: AppIcons.chevronDown,
                            imageType: ImageType.svg,
                            size: 24.h,
                          )
              ],
            ),
          ),
        ),
        isClicked
            ? widget
                .content *//*Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.container,
            border: Border.all(color: AppColors.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              CustomText(
                text: 'Maid 1',
                fontWeight: FontWeight.w400,
                fontSize: 14.h,
                color: AppColors.secondaryColor,
              ),
              CustomText(
                text: 'Maid 1',
                fontWeight: FontWeight.w400,
                fontSize: 14.h,
                color: AppColors.secondaryColor,
              ),
            ],
          ),
        )*//*
            : SizedBox()
      ],
    );
  }
}*/

import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(
            imageSrc: AppImages.noData,
            imageType: ImageType.png,
            size: 70.sp,
          ),
          CustomText(
            text: AppStrings.noData,
            fontSize: 16.h,
            top: 8.h,
          )
        ],
      ),
    );
  }
}

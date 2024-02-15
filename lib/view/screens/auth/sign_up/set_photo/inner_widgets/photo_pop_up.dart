import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/sign_up_controller/sign_up_controller.dart';

class PhotoPopUp extends StatefulWidget {
  const PhotoPopUp({super.key});

  @override
  State<PhotoPopUp> createState() => _PhotoPopUpState();
}

class _PhotoPopUpState extends State<PhotoPopUp> {
  SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .3,
        // height: 300.h,
        decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Column(children: [
          CustomText(
            text: AppStrings.chooseSource,
            color: AppColors.blue_500,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            bottom: 24.h,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.blue_400,
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              controller.gallery();
            },
            child: CustomText(
              text: AppStrings.gallery,
              color: AppColors.black_500,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              bottom: 24.h,
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.black_100,
          ),
          SizedBox(
            height: 24.h,
          ),
          GestureDetector(
            onTap: () {
              controller.camera();
            },
            child: CustomText(
              text: AppStrings.camera,
              color: AppColors.black_500,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              bottom: 24.h,
            ),
          ),
        ]));
  }
}

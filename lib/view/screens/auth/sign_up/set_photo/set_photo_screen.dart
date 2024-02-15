import 'dart:io';

import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';

import 'package:dialogi_app/view/screens/auth/sign_up/set_photo/inner_widgets/photo_pop_up.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/sign_up_controller/sign_up_controller.dart';

class SetPhotoScreen extends StatefulWidget {
  const SetPhotoScreen({super.key});

  @override
  State<SetPhotoScreen> createState() => _SetPhotoScreenState();
}

class _SetPhotoScreenState extends State<SetPhotoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(
    appBarContent: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const CustomImage(
          imageSrc: AppIcons.chevronLeft,
          size: 24,
        )),
          ),
          body: GetBuilder<SignUpController>(
    builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Set Profile Picture
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppStrings.setProfilePicture,
                  color: AppColors.blue_500,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  top: 24.h,
                  bottom: 8.h,
                ),

                ///fp text
                CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  text: AppStrings.pleaseuploadApicture,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  bottom: 44.h,
                ),

                ///photo
                Center(
                  child: GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context){
                            return const PhotoPopUp();
                          });
                    },
                    child:controller.image!= null ? Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.blue_400,width: 1),
                        image: DecorationImage(image: FileImage(File(controller.image!)),
                        fit: BoxFit.cover
                        )
                      ),
                    ) : Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.blue_400,width: 1)
                      ),
                      child: const Icon(Icons.person_outline_outlined,size: 24,color: AppColors.blue_400,),
                    ),
                  ),
                ),
              ],
            ),

            Column(
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.signInScreen);
                  },
                  titleText: AppStrings.skip,
                  buttonWidth: MediaQuery.of(context).size.width,
                  buttonColor: Colors.white,
                  borderColor: Colors.black,
                  titleColor: Colors.black87,
                ),
                SizedBox(height: 24.h,),
                CustomElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.signInScreen);
                  },
                  titleText: AppStrings.getStarted,
                  buttonWidth: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ],
        ),
      );
    }
          ),
        );
  }
}

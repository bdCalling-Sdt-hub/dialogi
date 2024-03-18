import 'package:dialogi_app/controllers/group_chat/select_friends_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void createGroupPopUp(
    {required BuildContext context,
      required String questionId ,
    String title = AppStrings.setGroupName,
    String buttonText = AppStrings.create}) {
  final SelectFriendsController selectFriendsController =
      Get.put(SelectFriendsController());
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.whiteColor,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 280.h,
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                fontWeight: FontWeight.w500,
                text: AppStrings.setName,
              ),
              CustomTextField(
                textEditingController: selectFriendsController.nameController,
                hintText: AppStrings.entertheName,
              ),
              SizedBox(
                width: double.maxFinite,
                child: CustomElevatedButton(
                    onPressed: () {
                      navigator!.pop();
                      selectFriendsController.createNewGroup(questionId) ;

                    },
                    titleText: buttonText),
              )
            ],
          ),
        ),
      );
    },
  );
}

void permissionPopUp({
  required BuildContext context,
  String title = AppStrings.doyouWantToDeletethisGroup,
  required VoidCallback ontapYes,
  required VoidCallback ontapNo,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          height: 130.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                fontSize: 14.w,
                fontWeight: FontWeight.w500,
                text: title,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                      buttonWidth: 120.w,
                      buttonHeight: 36.h,
                      titleColor: AppColors.black_500,
                      borderColor: AppColors.black_500,
                      buttonColor: Colors.transparent,
                      onPressed: () {
                        navigator!.pop();
                        ontapYes();
                      },
                      titleText: AppStrings.yes.tr),
                  CustomElevatedButton(
                      buttonWidth: 120.w,
                      buttonHeight: 36.h,
                      onPressed: () {
                        navigator!.pop();
                        ontapNo();
                      },
                      titleText: AppStrings.no.tr),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

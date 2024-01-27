import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/group_chat/select_friends/create_group_popup.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const CustomImage(
                    imageSrc: AppIcons.cancel,
                    size: 24,
                  )),
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomText(
              textAlign: TextAlign.start,
              maxLines: 3,
              text: AppStrings.enteryourCurrentPasswordToDelete,
              fontWeight: FontWeight.w500,
              bottom: 16.h,
            ),

            ///password
            CustomTextField(
              isPassword: true,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.enteryourpassword,
              hintStyle: GoogleFonts.prompt(
                  fontSize: 14.h,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_300),
              inputTextStyle: GoogleFonts.prompt(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.h,
                  color: AppColors.black_500),
              fieldBorderColor: Colors.white,
              fieldBorderRadius: 8,
              isPrefixIcon: true,
              prefixIcon: Icon(
                Icons.lock_outlined,
                size: 24.h,
                color: AppColors.blue_500,
              ),
            ),
            SizedBox(
              height: 44.h,
            ),
            CustomElevatedButton(
              onPressed: () {
                permissionPopUp(
                    title: AppStrings.areYouSure,
                    context: context,
                    ontapYes: () {
                      navigator!.pop();
                    },
                    ontapNo: () {});
              },
              titleText: AppStrings.deleteAccount,
              buttonColor: AppColors.red_500,
              buttonWidth: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}

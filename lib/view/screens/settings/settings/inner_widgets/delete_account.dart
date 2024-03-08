import 'package:dialogi_app/controllers/Auth/delete_account_controller.dart';
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

import '../../../../../helper/prefs_helper.dart';
import '../../../../../utils/api_static_string.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  DeleteAccountController deleteAccountController =
      Get.find<DeleteAccountController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              if (!PrefsHelper.isProvider)
              SizedBox(
                height: 16.h,
              ),
              PrefsHelper.isProvider ?
                  CustomText(text: AppStrings.areYouSure, fontSize: 18.sp,) :
                CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  text: AppStrings.enteryourCurrentPasswordToDelete,
                  fontWeight: FontWeight.w500,
                  bottom: 16.h,
                ),

              ///<<<================== password text field ====================>>>

              if (!PrefsHelper.isProvider)
                CustomTextField(
                  textEditingController:
                      deleteAccountController.passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ApiStaticStrings.fieldCantBeEmpty;
                    } else {
                      return null;
                    }
                  },
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
                height: PrefsHelper.isProvider ? 24.h :44.h,
              ),

              ///<<<================= Delete account button ===================>>>

              CustomElevatedButton(
                onPressed: () {

                  if (PrefsHelper.isProvider) {
                    buildPermissionPopUp(context);
                  } else {
                    if (_formKey.currentState!.validate()) {
                      buildPermissionPopUp(context);
                    }
                  }



                },
                titleText: AppStrings.deleteAccount,
                buttonColor: AppColors.red_500,
                buttonWidth: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }

  void buildPermissionPopUp(BuildContext context) {
    return permissionPopUp(
                    title: AppStrings.areYouSure,
                    context: context,
                    ontapYes: () {
                      deleteAccountController.deleteAccountRepo();

                    },
                    ontapNo: () {
                      Get.back();
                    });
  }
}

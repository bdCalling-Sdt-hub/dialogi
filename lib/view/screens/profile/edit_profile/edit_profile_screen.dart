import 'package:dialogi_app/controllers/profile_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../services/api_url.dart';
import '../../../widgets/profile_custom/profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  String date = "";

  @override
  Widget build(BuildContext context) {

    profileController.nameController.text = profileController.profileModel.data?.attributes?.fullName ?? "" ;
    profileController.dateController.text = profileController.profileModel.data?.attributes?.dateOfBirth ?? "" ;
    profileController.addressController.text = profileController.profileModel.data?.attributes?.address ?? "" ;
    return Scaffold(
      appBar: CustomAppBar(
          appBarContent: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const CustomImage(
                imageSrc: AppIcons.chevronLeft,
                size: 24,
              )),
          CustomText(
            text: AppStrings.editProfile,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.blue_500,
          ),
          const SizedBox(),
        ],
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          children: [

            ProfileImage(imageURl: "${ApiConstant.baseUrl}${profileController.profileModel.data!.attributes!.image!}"),

            SizedBox(height: 44.h,),
            ///<-------- name --------->
            CustomTextField(
              textEditingController: profileController.nameController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.enterName,
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
                Icons.person_outline_outlined,
                size: 24.h,
                color: AppColors.blue_500,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),

            /// <---------- date of birth -------->
            CustomTextField(
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now());

                date =
                "${selectedDate!.year}-${selectedDate.month}-${selectedDate.day}";

                profileController.dateController.text = date;

                // profileController.dateController.text = date;
              },
              readOnly: true,
              textEditingController: profileController.dateController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.dob,
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
              prefixIcon: GestureDetector(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now());

                  date =
                      "${selectedDate!.year}-${selectedDate.month}-${selectedDate.day}";

                  profileController.dateController.text = date;
                },
                child: Icon(
                  Icons.date_range_outlined,
                  size: 24.h,
                  color: AppColors.blue_500,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),

            /// <----------- location --------->
            CustomTextField(
              textEditingController: profileController.addressController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.address,
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
                Icons.location_on_outlined,
                size: 24.h,
                color: AppColors.blue_500,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: CustomElevatedButton(
            onPressed: () => profileController.updateProfileRepo(),
            titleText: AppStrings.update),
      ),
    );
  }
}

import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  final List locale = [
    {"name": "English", "locale" : const Locale("en", "US")},
    {"name": "German", "locale" : const Locale("de", "DE")}
  ];
  updateLanguage(Locale locale){
    Get.updateLocale(locale);
  }

  List<String> language=[
    AppStrings.english,
    AppStrings.german
  ];
  int selectedItem=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: const CustomImage(
                  imageSrc: AppIcons.chevronLeft,
                  size: 24,
                ),
              ),
              CustomText(
                text: AppStrings.changeLanguage,
                fontWeight: FontWeight.w500,
                fontSize: 18.h,
                color: AppColors.blue_500,
              ),
              const SizedBox()
            ],
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: Column(
          children: [
            Text(AppStrings.myText.tr),
            Column(
              children: List.generate(
                  language.length,
                      (index) => GestureDetector(
                onTap: (){
                    selectedItem = index;
                    Get.updateLocale(locale[index]["locale"]);
                    print("Language is: ---------------->> ${locale[index]["name"]}, ${locale[index]["locale"]}");

                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: const BoxDecoration(
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: AppColors.blue_500, width: 1),
                          color: index == selectedItem
                              ? AppColors.blue_500
                              : Colors.white,
                        ),
                      ),
                      CustomText(
                        text: language[index],
                        color: AppColors.black_500,
                        left: 16,
                      ),
                    ],
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}

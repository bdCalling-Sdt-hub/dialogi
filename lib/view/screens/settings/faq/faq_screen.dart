import 'package:dialogi_app/controllers/settings_controller/settings_controller.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  SettingsController settingsController = Get.find<SettingsController>();
  bool selectedIndex = false;
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
          CustomText(
            text: AppStrings.fAQ.tr,
            fontWeight: FontWeight.w500,
            fontSize: 18.h,
            color: AppColors.blue_500,
          ),
          const SizedBox()
        ],
      )),
      body: Obx(
        () => settingsController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : settingsController.isGetData.value
                ? SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 20),
                    child: Column(children: [
                      Column(
                        children: List.generate(
                            settingsController
                                .faqContentModelData!.data!.attributes!.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = !selectedIndex;
                                      currentIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                text:
                                                    "${settingsController.faqContentModelData!.data!.attributes![index].question}",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            selectedIndex && currentIndex == index
                                                ? const Icon(
                                                    Icons.remove_circle_outline)
                                                : const Icon(
                                                    Icons.add_circle_outline)
                                          ],
                                        ),
                                        selectedIndex && currentIndex == index
                                            ? Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  CustomText(
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 10,
                                                      text:
                                                          "${settingsController.faqContentModelData!.data!.attributes![index].answer}"),
                                                ],
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    ]),
                  )
                : ErrorScreen(onTap: () {
                    settingsController.faqRepo();
                  }),
      ),
    );
  }
}

import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
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
  bool selectedIndex = false;

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
            text: AppStrings.fAQ,
            fontWeight: FontWeight.w500,
            fontSize: 18.h,
            color: AppColors.blue_500,
          ),
          const SizedBox()
        ],
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(children: [
          Column(
            children: List.generate(
                1,
                (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = !selectedIndex;
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
                                const Expanded(
                                  child: CustomText(
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    text:
                                        'Lorem ipsum dolor sit amet consectetur?',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                selectedIndex
                                    ? const Icon(Icons.remove_circle_outline)
                                    : const Icon(Icons.add_circle_outline)
                              ],
                            ),
                            selectedIndex
                                ? const Column(
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      CustomText(
                                        textAlign: TextAlign.start,
                                        maxLines: 10,
                                        text:
                                            'Lorem ipsum dolor sit amet consectetur. Vel augue orci faucibus fringilla lacus turpis porttitor. Posuere magna cursus parturient augue ut pellentesque suspendisse aliquam nisi. Accumsan eget suspendisse nulla quis semper.',
                                      ),
                                    ],
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    )),
          ),
        ]),
      ),
    );
  }
}

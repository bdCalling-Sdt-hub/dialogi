import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/question_ans/inner_widget/comment_reply/comment_reply.dart';
import 'package:dialogi_app/view/screens/question_ans/inner_widget/premium_text.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class QuestionAns extends StatelessWidget {
  const QuestionAns({super.key});

  @override
  Widget build(BuildContext context) {
    String? title = Get.parameters["title"];
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(24.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomElevatedButton(
                buttonHeight: 36, onPressed: () {}, titleText: AppStrings.skip)
          ],
        ),
      ),
      //AppBar

      appBar: CustomAppBar(
          appBarContent: Row(
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                right: 20.w,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.blue_500,
                text: title!,
              ),
            ),
          )
        ],
      )),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            //Question Box

            Container(
              width: double.maxFinite,
              height: 120.h,
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Column(
                children: [
                  const Expanded(
                    child: CustomText(
                      maxLines: 2,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      text: "What does FriendShip mean to you?",
                    ),
                  ),

                  //Specker Icon
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                          onTap: () async {
                            FlutterTts flutterTts = FlutterTts();
                            await flutterTts
                                .speak("What does FriendShip mean to you?");
                          },
                          child:
                              const CustomImage(imageSrc: AppIcons.volumeup)))
                ],
              ),
            ),

            //Answer Box

            Padding(
              padding: EdgeInsets.only(top: 16.h, bottom: 20.h),
              child: const CustomTextField(
                maxLines: 3,
                hintText: AppStrings.enteryouranswer,
              ),
            ),

            //Next Button

            CustomElevatedButton(
                buttonWidth: double.maxFinite,
                onPressed: () {},
                titleText: AppStrings.next),

            //const PremiumText()
            Expanded(child: CommentReply())
          ],
        ),
      ),
    );
  }
}

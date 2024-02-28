import 'package:dialogi_app/controllers/question_ans_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:dialogi_app/view/screens/question_ans/inner_widget/comment_reply/comment_reply.dart';
import 'package:dialogi_app/view/screens/question_ans/inner_widget/discussion_platform.dart';
import 'package:dialogi_app/view/widgets/alert_dialog/alert_dialog.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/subscription_popup/subcription_popup.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class QuestionAns extends StatefulWidget {
  const QuestionAns({super.key});

  @override
  State<QuestionAns> createState() => _QuestionAnsState();
}

class _QuestionAnsState extends State<QuestionAns> {
  String title = Get.parameters["title"] ?? "";

  QuestionAnsController questionAnsController =
      Get.put(QuestionAnsController());

  @override
  void initState() {
    // TODO: implement initState

    questionAnsController.discussionPage = 1;
    questionAnsController.questionsRepo(title);
    questionAnsController.discussionScrollController.addListener(() {
      questionAnsController.scrollControllerCall(title);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                text: title,
              ),
            ),
          )
        ],
      )),
      body: GetBuilder<QuestionAnsController>(
        builder: (controller) {
          return switch (controller.status) {
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error =>
              ErrorScreen(onTap: () => controller.questionsRepo(title)),
            Status.completed => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    //Question Box

                    Container(
                      width: double.maxFinite,
                      height: 110.h,
                      padding: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: CustomText(
                              maxLines: 2,
                              fontSize: 16.w,
                              fontWeight: FontWeight.w500,
                              text: controller.questionAnsModel!.data!
                                  .attributes!.questions![0].question!,
                            ),
                          ),
                          Row(
                            children: [
                              //==============================Specker Icon========================
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: IconButton(
                                      onPressed: () async {
                                        print(
                                            "=================================================================> What does Friendship mean to you?");
                                        FlutterTts flutterTts = FlutterTts();
                                        await flutterTts.speak(controller
                                            .questionAnsModel!
                                            .data!
                                            .attributes!
                                            .questions![0]
                                            .question!);
                                      },
                                      icon: const CustomImage(
                                          imageSrc: AppIcons.volumeup))),

                              //==============================Share Icon========================

                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const CustomImage(
                                          imageSrc: AppIcons.share))),

                              //==============================favorite Icon========================
                              const Spacer(),
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: IconButton(
                                      onPressed: () => controller.addFavouriteRepo(),
                                      icon: controller
                                              .questionAnsModel!
                                              .data!
                                              .attributes!
                                              .questions![0]
                                              .isFavourite!
                                          ? const Icon(Icons.favorite)
                                          : const Icon(
                                              Icons.favorite_border_outlined))),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //==============================Answer Box=========================

                    Padding(
                      padding: EdgeInsets.only(top: 16.h, bottom: 20.h),
                      child: CustomTextField(
                        height: 90.h,
                        maxLines: 2,
                        textEditingController: controller.discussionController,
                        hintText: AppStrings.enteryouranswer,
                      ),
                    ),

                    //=============================Next Button=========================

                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                              onPressed: () {
                                if (controller.page != controller.totalPages) {
                                  controller.page = controller.page + 1;
                                  controller.discussionPage = 1;
                                  controller.discussionList = [];
                                  controller.discussionController.clear();
                                  controller.questionsRepo(title);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialogs(
                                            successtext: AppStrings.greatJob,
                                            completeText:
                                                AppStrings.youHaveCompleted,
                                            buttonText:
                                                AppStrings.gotocategories,
                                            onPressed: () {
                                              Get.toNamed(
                                                  AppRoutes.categoryScreen);
                                            });
                                      });
                                }
                              },
                              titleText: AppStrings.skip),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: CustomElevatedButton(
                              onPressed: () {
                                controller.addDiscussionRepo(title);
                              },
                              titleText: AppStrings.add),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 44.h,
                    ),

                    //================If its not premium then show upgrade to premium option===========

                    //   const UpgradePremium()

                    Homecontroller.accessStatusModel!.data!.type != "default"
                        ? const Expanded(child: CommentReply())
                        : Column(
                            children: [
                              const CustomText(
                                  text: AppStrings.wanttojointhediscussion),
                              SizedBox(
                                height: 8.h,
                              ),
                              InkWell(
                                onTap: () =>
                                    Get.toNamed(AppRoutes.subscriptionsScreen),
                                child: CustomText(
                                  text: AppStrings.upgradetoPremium,
                                  color: AppColors.blue_500,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
          };
        },
      ),
      bottomNavigationBar: GetBuilder<QuestionAnsController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(24.r),
            child: Row(
              children: [
                //=========================Discuss with friend========================

                Expanded(
                  flex: 2,
                  child: CustomElevatedButton(
                      buttonColor: AppColors.whiteColor,
                      borderColor: AppColors.black_600,
                      titleColor: AppColors.black_400,
                      titleSize: 14.w,
                      buttonHeight: 36,
                      onPressed: () {
                        //   Get.toNamed(AppRoutes.selectFriends);
                        chooseDiscussPlatform(context: context);
                      },
                      titleText: AppStrings.discusswithFriends),
                ),
                SizedBox(
                  width: 10.w,
                ),

                //=========================Skip========================

                Expanded(
                  child: CustomElevatedButton(
                      titleSize: 14.w,
                      buttonHeight: 36,
                      onPressed: () {
                        if (controller.page != controller.totalPages) {
                          controller.page = controller.page + 1;
                          controller.discussionPage = 1;
                          controller.discussionList = [];
                          controller.questionsRepo(title);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialogs(
                                    successtext: AppStrings.greatJob,
                                    completeText: AppStrings.youHaveCompleted,
                                    buttonText: AppStrings.gotocategories,
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.categoryScreen);
                                    });
                              });
                        }
                      },
                      titleText: AppStrings.next),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

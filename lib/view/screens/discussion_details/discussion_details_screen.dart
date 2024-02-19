import 'package:dialogi_app/controllers/question_ans_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/discussion_details_controller.dart';
import '../../../services/api_url.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/static_strings.dart';
import '../../widgets/image/custom_image.dart';
import '../../widgets/text/custom_text.dart';

class DiscussionDetailsScreen extends StatefulWidget {
  const DiscussionDetailsScreen({super.key});

  @override
  State<DiscussionDetailsScreen> createState() =>
      _DiscussionDetailsScreenState();
}

class _DiscussionDetailsScreenState extends State<DiscussionDetailsScreen> {
  String discussionID = Get.parameters["discussionID"] ?? "";

  DiscussionDetailsController discussionDetailsController =
      Get.put(DiscussionDetailsController());

  QuestionAnsController questionAnsController =
      Get.put(QuestionAnsController());

  @override
  void initState() {
    discussionDetailsController.discussionDetailsRepo(discussionID);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "============================================================> discussionID $discussionID");
    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<DiscussionDetailsController>(
          builder: (controller) {
            return controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image of the main comment person
                            Container(
                              width: 26.w,
                              height: 26.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${ApiConstant.baseUrl}/${controller.discussionDetailsModel!.data!.attributes!.discussion!.user!.image}"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Name and comment of the main comment person
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: controller
                                        .discussionDetailsModel!
                                        .data!
                                        .attributes!
                                        .discussion!
                                        .user!
                                        .fullName!),
                                const SizedBox(height: 8),
                                CustomText(
                                  textAlign: TextAlign.left,
                                  text: controller.discussionDetailsModel!.data!
                                      .attributes!.discussion!.discussion!,
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Like Dislike reply
                        Padding(
                          padding: EdgeInsets.only(left: 35.w, top: 5.h),
                          child: Row(
                            children: [
                              // Like
                              Row(
                                children: [
                                  const CustomImage(imageSrc: AppIcons.like),
                                  SizedBox(width: 10.w),
                                  CustomText(
                                      text: controller.discussionDetailsModel!
                                          .data!.attributes!.discussion!.likes
                                          .toString()),
                                ],
                              ),
                              SizedBox(width: 10.w),

                              // Dislike
                              Row(
                                children: [
                                  const CustomImage(imageSrc: AppIcons.dislike),
                                  SizedBox(width: 10.w),
                                  CustomText(
                                      text: controller
                                          .discussionDetailsModel!
                                          .data!
                                          .attributes!
                                          .discussion!
                                          .dislikes
                                          .toString()),
                                ],
                              ),

                              InkWell(
                                onTap: () => questionAnsController
                                    .addReply(discussionID),
                                child: Center(
                                    child: CustomText(
                                  text: AppStrings.reply,
                                  left: 10.w,
                                  right: 10.w,
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        Expanded(
                          // height: 100.h,
                          child: Padding(
                            padding: EdgeInsets.only(left: 35.w),
                            child: ListView.builder(
                              itemCount: controller.repliesList.length,
                              itemBuilder: (context, index) {
                                var item = controller.repliesList[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 26.w,
                                          height: 26.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${ApiConstant.baseUrl}/${item.user!.image!}"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),

                                        // Name and comment of the Reply person
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                                text: item.user!.fullName!),
                                            const SizedBox(height: 8),
                                            CustomText(
                                              textAlign: TextAlign.left,
                                              text: item.reply!,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // Like Dislike reply
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 35.w, top: 5.h),
                                      child: Row(
                                        children: [
                                          // Like
                                          Row(
                                            children: [
                                              const CustomImage(
                                                  imageSrc: AppIcons.like),
                                              SizedBox(width: 10.w),
                                              CustomText(
                                                  text: item.likes.toString()),
                                            ],
                                          ),
                                          SizedBox(width: 10.w),

                                          // Dislike
                                          Row(
                                            children: [
                                              const CustomImage(
                                                  imageSrc: AppIcons.dislike),
                                              SizedBox(width: 10.w),
                                              CustomText(
                                                  text:
                                                      item.dislikes.toString()),
                                            ],
                                          ),

                                          // Reply
                                          TextButton(
                                            onPressed: () {},
                                            child: const CustomText(
                                                text: AppStrings.reply),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ));
  }
}

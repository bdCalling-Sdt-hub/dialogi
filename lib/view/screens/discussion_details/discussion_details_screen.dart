

import 'package:dialogi_app/controllers/question_ans_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../services/api_url.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/static_strings.dart';
import '../../widgets/image/custom_image.dart';
import '../../widgets/text/custom_text.dart';

class DiscussionDetailsScreen extends StatefulWidget {
  const DiscussionDetailsScreen({super.key});

  @override
  State<DiscussionDetailsScreen> createState() => _DiscussionDetailsScreenState();
}

class _DiscussionDetailsScreenState extends State<DiscussionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<QuestionAnsController>(builder: (controller) {
        return ListView.builder(
          itemCount: controller.questionAnsModel!.data!.attributes!
              .questions![0].discussions!.length,
          itemBuilder: (context, index) {
            var comment = controller.questionAnsModel!.data!.attributes!
                .questions![0].discussions![index];
            return Column(
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
                              "${ApiConstant.baseUrl}/${comment.user!.image}"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Name and comment of the main comment person
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: comment.user!.fullName!),
                        const SizedBox(height: 8),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: comment.discussion!,
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
                          CustomText(text: comment.likes.toString()),
                        ],
                      ),
                      SizedBox(width: 10.w),

                      // Dislike
                      Row(
                        children: [
                          const CustomImage(imageSrc: AppIcons.dislike),
                          SizedBox(width: 10.w),
                          CustomText(text: comment.dislikes.toString()),
                        ],
                      ),

                      // Reply
                      TextButton(
                        onPressed: () {},
                        child: const CustomText(text: AppStrings.reply),
                      ),
                    ],
                  ),
                ),

                // ================================Replies======================
                Container(
                  margin: EdgeInsets.only(left: 30.w),
                  // height: 100.h,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: comment.limitedReplies!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      print(
                          "=======================================>comment.limitedReplies!.length ${comment.limitedReplies!.length}");
                      var reply = comment.limitedReplies![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image of the Reply person
                              Container(
                                width: 26.w,
                                height: 26.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${ApiConstant.baseUrl}/${reply.user!.image!}"),
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
                                  CustomText(text: reply.user!.fullName!),
                                  const SizedBox(height: 8),
                                  CustomText(
                                    textAlign: TextAlign.left,
                                    text: reply.reply!,
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
                                    const CustomImage(
                                        imageSrc: AppIcons.like),
                                    SizedBox(width: 10.w),
                                    CustomText(
                                        text: reply.likes.toString()),
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
                                        text: reply.dislikes.toString()),
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
              ],
            );
          },
        ) ;
    },
    ));
  }
}

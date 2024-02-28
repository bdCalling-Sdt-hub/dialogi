import 'package:dialogi_app/controllers/question_ans_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../services/api_url.dart';

class CommentReply extends StatelessWidget {
  const CommentReply({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionAnsController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //============================Discuss Text=======================

          CustomText(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            text: AppStrings.discussions,
            bottom: 16.h,
          ),

          //===========================Comment reply section=======================

          Expanded(
              child: controller.isAddDiscussion
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: controller.discussionScrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.isLoadingMoreDiscussion
                          ? controller.discussionList.length + 1
                          : controller.discussionList.length,
                      itemBuilder: (context, index) {
                        if (index < controller.discussionList.length) {
                          var comment = controller.discussionList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image of the main comment person
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.friendsProfileScreen,
                                          parameters: {
                                            "userID": "${comment.user!.sId}"
                                          });
                                    },
                                    child: Container(
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
                                  ),
                                  const SizedBox(width: 8),

                                  // Name and comment of the main comment person
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: comment.user!.fullName!),
                                        const SizedBox(height: 8),
                                        CustomText(
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          text: comment.discussion!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // Like Dislike reply
                              Padding(
                                padding: EdgeInsets.only(left: 35.w, top: 5.h),
                                child: Row(
                                  children: [
                                    // Like
                                    GestureDetector(
                                      onTap: () {
                                        controller.discussionLike(
                                            comment.sId, index);
                                      },
                                      child: controller.isLike
                                          ? const CircularProgressIndicator()
                                          : Row(
                                              children: [
                                                comment.isLiked
                                                    ? CustomImage(
                                                        imageSrc:
                                                            AppImages.isLike,
                                                        imageType:
                                                            ImageType.png,
                                                        size: 18.sp,
                                                      )
                                                    : const CustomImage(
                                                        imageSrc: AppIcons.like,
                                                      ),
                                                SizedBox(width: 10.w),
                                                CustomText(
                                                    text: comment.likes
                                                        .toString()),
                                              ],
                                            ),
                                    ),
                                    SizedBox(width: 10.w),

                                    // Dislike
                                    GestureDetector(
                                      onTap: () => controller.discussionDislike(
                                          comment.sId, index),
                                      child: controller.isDislike
                                          ? const CircularProgressIndicator()
                                          : Row(
                                              children: [
                                                comment.isDisliked
                                                    ? CustomImage(
                                                        imageSrc:
                                                            AppImages.isDislike,
                                                        size: 14.sp,
                                                        imageType:
                                                            ImageType.png,
                                                        imageColor:
                                                            AppColors.blue_500,
                                                      )
                                                    : const CustomImage(
                                                        imageSrc:
                                                            AppIcons.dislike),
                                                SizedBox(width: 10.w),
                                                CustomText(
                                                    text: comment.dislikes
                                                        .toString()),
                                              ],
                                            ),
                                    ),

                                    InkWell(
                                      onTap: () => controller.addReply(
                                          comment.sId!, index),
                                      child: Center(
                                          child: CustomText(
                                        text: AppStrings.reply,
                                        left: 10.w,
                                        right: 10.w,
                                        textAlign: TextAlign.center,
                                      )),
                                    ),

                                    // ReplyS
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    left: 45.w, bottom: 16.h, top: 12.h),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.discussionDetails,
                                        parameters: {
                                          "discussionID": "${comment.sId!}"
                                        });
                                  },
                                  child: controller.isLoadingReplay
                                      ? controller.indexNumber == index
                                          ? SizedBox(
                                              height: 16.w,
                                              width: 16.w,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.w,
                                              ))
                                          : CustomText(
                                              text:
                                                  "${AppStrings.view} ${comment.totalReplies} ${AppStrings.reply}",
                                              color: AppColors.blue_600,
                                            )
                                      : CustomText(
                                          text:
                                              "${AppStrings.view} ${comment.totalReplies} ${AppStrings.reply}",
                                          color: AppColors.blue_600,
                                        ),
                                ),
                              ),

                              /// ================================Replies======================
                              // Container(
                              //   margin: EdgeInsets.only(left: 30.w),
                              //   // height: 100.h,
                              //   child: ListView.builder(
                              //     physics: const NeverScrollableScrollPhysics(),
                              //     itemCount:1,
                              //     shrinkWrap: true,
                              //     itemBuilder: (context, index) {
                              //       print(
                              //           "=======================================>comment.limitedReplies!.length ${comment.limitedReplies}");
                              //       var reply = comment.limitedReplies;
                              //       return Column(
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           Row(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               // Image of the Reply person
                              //               Container(
                              //                 width: 26.w,
                              //                 height: 26.w,
                              //                 decoration: BoxDecoration(
                              //                   shape: BoxShape.circle,
                              //                   image: DecorationImage(
                              //                     image: NetworkImage(
                              //                         "${ApiConstant.baseUrl}/${reply!.user!.image}"),
                              //                     fit: BoxFit.fill,
                              //                   ),
                              //                 ),
                              //               ),
                              //               const SizedBox(width: 8),
                              //
                              //               // Name and comment of the Reply person
                              //               Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   CustomText(text: reply.user!.fullName!),
                              //                   const SizedBox(height: 8),
                              //                   CustomText(
                              //                     textAlign: TextAlign.left,
                              //                     text: reply.reply!,
                              //                   ),
                              //                 ],
                              //               ),
                              //             ],
                              //           ),
                              //
                              //           // Like Dislike reply
                              //           Padding(
                              //             padding: EdgeInsets.only(left: 35.w, top: 5.h),
                              //             child: Row(
                              //               children: [
                              //                 // Like
                              //                 Row(
                              //                   children: [
                              //                     const CustomImage(
                              //                         imageSrc: AppIcons.like),
                              //                     SizedBox(width: 10.w),
                              //                     CustomText(
                              //                         text: reply.likes.toString()),
                              //                   ],
                              //                 ),
                              //                 SizedBox(width: 10.w),
                              //
                              //                 // Dislike
                              //                 Row(
                              //                   children: [
                              //                     const CustomImage(
                              //                         imageSrc: AppIcons.dislike),
                              //                     SizedBox(width: 10.w),
                              //                     CustomText(
                              //                         text: reply.dislikes.toString()),
                              //                   ],
                              //                 ),
                              //
                              //                 // Reply
                              //                 TextButton(
                              //                   onPressed: () {},
                              //                   child: const CustomText(
                              //                       text: AppStrings.reply),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ],
                              //       );
                              //     },
                              //   ),
                              // ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    )),

          //===========================Text Input field===========================

          controller.isReplay
              ? Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      textEditingController: controller.replyController,
                      hintText: AppStrings.enterTextHere,
                    )),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: GestureDetector(
                          onTap: () => controller.addReplyRepo(),
                          child: controller.isLoadingReplay
                              ? const CircularProgressIndicator()
                              : const CustomImage(imageSrc: AppIcons.send)),
                    )
                  ],
                )
              : const SizedBox(),
        ],
      );
    });
  }
}

import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentReply extends StatelessWidget {
  CommentReply({super.key});

  final List<Map<String, Map>> comments = [
    {
      "comment": {
        "commentBody": "Nice. Keep going",
        "name": "Nils",
        "image":
            "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
        "likes": "34",
        "dislike": "4",
        "reply": [
          {
            "name": "Rafsan",
            "image":
                "https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
            "likes": "34",
            "dislike": "4",
            "replymsg": "Thank you"
          },
        ]
      }
    },
    {
      "comment": {
        "commentBody": "How to find that",
        "name": "Humayun",
        "image":
            "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
        "likes": "34",
        "dislike": "4",
        "reply": [
          {
            "name": "Nadim",
            "image":
                "https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
            "likes": "34",
            "dislike": "4",
            "replymsg": "In Comment section"
          },
        ]
      }
    }
  ];

  @override
  Widget build(BuildContext context) {
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

        SizedBox(
          height: 230.h,
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              var comment = comments[index]["comment"]!;
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
                            image: NetworkImage(comment["image"]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Name and comment of the main comment person
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: comment["name"]),
                          const SizedBox(height: 8),
                          CustomText(
                            textAlign: TextAlign.left,
                            text: comment["commentBody"],
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
                            CustomText(text: comment["likes"]),
                          ],
                        ),
                        SizedBox(width: 10.w),

                        // Dislike
                        Row(
                          children: [
                            const CustomImage(imageSrc: AppIcons.dislike),
                            SizedBox(width: 10.w),
                            CustomText(text: comment["dislike"]),
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
                    height: 100.h,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comment["reply"].length,
                      itemBuilder: (context, index) {
                        var reply = comment["reply"][index]!;
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
                                      image: NetworkImage(reply["image"]),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // Name and comment of the Reply person
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: reply["name"]),
                                    const SizedBox(height: 8),
                                    CustomText(
                                      textAlign: TextAlign.left,
                                      text: reply["replymsg"],
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
                                      CustomText(text: reply["likes"]),
                                    ],
                                  ),
                                  SizedBox(width: 10.w),

                                  // Dislike
                                  Row(
                                    children: [
                                      const CustomImage(
                                          imageSrc: AppIcons.dislike),
                                      SizedBox(width: 10.w),
                                      CustomText(text: reply["dislike"]),
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
          ),
        ),

        //===========================Text Input field===========================

        Row(
          children: [
            const Expanded(
                child: CustomTextField(
              hintText: AppStrings.enterTextHere,
            )),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: GestureDetector(
                  onTap: () {},
                  child: const CustomImage(imageSrc: AppIcons.send)),
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}

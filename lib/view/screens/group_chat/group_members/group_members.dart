import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupMembers extends StatefulWidget {
  const GroupMembers({super.key});

  @override
  State<GroupMembers> createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  @override
  Widget build(BuildContext context) {
    final List<Map> user = [
      {
        "image":
            "https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
        "name": "Rafsan"
      },
      {
        "image":
            "https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
        "name": "Humayun"
      },
      {
        "image":
            "https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
        "name": "Shanto"
      },
      {
        "image":
            "https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
        "name": "Nadim"
      },
      {
        "image":
            "https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
        "name": "Polash"
      }
    ];
 
    return Scaffold(
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
                  text: AppStrings.groupMembers,
                ),
              ),
            )
          ],
        )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: ListView.builder(
            itemCount: user.length,
            itemBuilder: (context, index) {
              var lastIndex = user.length - 1;

              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50.w,
                        width: 50.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(user[index]["image"]))),
                      ),
                      CustomText(
                        left: 16,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                        text: user[index]["name"],
                      ),
                    ],
                  ),
                  if (index != lastIndex)
                    Container(
                      height: 2.h,
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(
                        vertical: 14.h,
                      ),
                      color: AppColors.gray_600,
                    )
                ],
              );
            },
          ),
        ));
  }
}

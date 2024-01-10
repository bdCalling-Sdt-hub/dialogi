import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_pending_requests.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PendingRequestsScreen extends StatefulWidget {
  const PendingRequestsScreen({super.key});

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const CustomImage(imageSrc: AppIcons.chevronLeft,size: 24,)),
              const CustomText(
                text: AppStrings.pendingRequests,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.blue_500,
              ),
              const SizedBox(),

            ],
          )),
      body: Padding(
          padding:const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder:(BuildContext context,int index){
              return CustomPendingRequests(pendingText: 'Bassie sent you a request.', timeText: '1 hour ago', onTapReject: (){}, onTapAccept: (){});
            } ),
      ),
    );
  }
}

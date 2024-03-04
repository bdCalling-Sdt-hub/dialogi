

import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:get/get.dart';

import '../../utils/static_strings.dart';

class DiscussionPlatformController extends GetxController {
  String selectedPlatform = AppStrings.community;

  List<String> discussPlatform = [];



  checkDiscussion() {
    if(Homecontroller.accessStatusModel!.data!.isCommunityDiscussionAvailable == true) {
      discussPlatform.add(AppStrings.community) ;
    }


    if(Homecontroller.accessStatusModel!.data!.isGroupChatAvailable == true) {
      discussPlatform.add(AppStrings.group) ;
    }

  }




}
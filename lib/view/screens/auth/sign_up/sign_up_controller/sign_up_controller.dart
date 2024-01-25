import 'package:dialogi_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController{

  TextEditingController dobController = TextEditingController();


  Future<void> dateofbirthPicker(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme:  const ColorScheme.light(
              background: AppColors.whiteColor,
              primary: AppColors.blue_500, // <-- SEE HERE
              // onPrimary: AppColors.black_300, // <-- SEE HERE
              onSurface: AppColors.black_500, // <-- SEE HERE
            ),
          ),
          child: child!
      ),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    // ignore: unrelated_type_equality_checks
    if (picked != null && picked !=dobController.text) {
      dobController.text = "${picked.year}/${picked.month}/${picked.day}";
      update();
    }
  }


  String? image;
  gallery()async{
    final ImagePicker picker = ImagePicker();
    final XFile? getImages = await picker.pickImage(source: ImageSource.gallery);
    if(getImages != null){
      image = getImages.path;
      navigator!.pop();
      update();
    }
  }
  camera()async{
    final ImagePicker picker = ImagePicker();
    final XFile? getImages = await picker.pickImage(source: ImageSource.camera);
    if(getImages != null){
      image = getImages.path;
      navigator!.pop();
      update();
    }
  }
}
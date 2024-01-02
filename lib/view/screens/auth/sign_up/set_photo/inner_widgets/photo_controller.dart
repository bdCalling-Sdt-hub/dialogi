import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoController extends GetxController{
  String? image;
  gallery()async{
    final ImagePicker picker = ImagePicker();
    final XFile? getImages = await picker.pickImage(source: ImageSource.gallery);
    if(getImages != null){
      image = getImages.path;
     update();
    }
  }
  camera()async{
    final ImagePicker picker = ImagePicker();
    final XFile? getImages = await picker.pickImage(source: ImageSource.camera);
    if(getImages != null){
      image = getImages.path;
      update();
    }
  }
}
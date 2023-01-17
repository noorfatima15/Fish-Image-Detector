import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageDataController extends GetxController {
  var pickedImage;
  var pickedImageFile = [].obs;

  RxString pickedImageTitle = ''.obs;

  Future pickImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    pickedImage = File(image.path);

    pickedImageFile.value.add(pickedImage);

    update();
  }

  Future predictImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    pickedImage = File(image.path);
  }
}

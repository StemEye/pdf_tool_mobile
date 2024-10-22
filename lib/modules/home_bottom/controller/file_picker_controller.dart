import 'package:get/get.dart';

class FilePickerController extends GetxController {
  // Observable for the picked file path
  var pickedFilePath = ''.obs;

  // Function to update file path after file is picked
  void updateFilePath(String newPath) {
    pickedFilePath.value = newPath;
  }
}

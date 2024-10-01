import 'package:get/get.dart';

class DropdownController extends GetxController {
  var selectedLevel = 2.obs; // default value is 2

  void updateLevel(int level) {
    selectedLevel.value = level;
  }
}

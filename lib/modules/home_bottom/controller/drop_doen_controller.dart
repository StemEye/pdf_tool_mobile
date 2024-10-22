import 'package:get/get.dart';

class DropdownController extends GetxController {
  var selectedLevel = ''.obs; // default value is 2
  var selectedPages = '2'.obs;

  void updateLevel(String level) {
    selectedLevel.value = level;
  }

  void updatePage(String pages) {
    selectedPages.value = pages;
  }
}

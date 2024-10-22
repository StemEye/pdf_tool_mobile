import 'package:get/get.dart';

class HomeToggelController extends GetxController {
  // This flag will control the layout
  var isStacked = false.obs;

  // Method to toggle the layout
  void toggleLayout() {
    isStacked.value = !isStacked.value;
  }
}

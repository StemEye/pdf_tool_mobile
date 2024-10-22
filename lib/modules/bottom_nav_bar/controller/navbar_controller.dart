import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/data/network/api_provider.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

class NavbarController extends GetxController {
  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;

    if (index == 1) {
      // For FilesView, initialize HomeController if not already registered
      if (!Get.isRegistered<HomeController>()) {
        Get.lazyPut(() => HomeController(Get.find<ApiProvider>()));
      }
    }
  }
}

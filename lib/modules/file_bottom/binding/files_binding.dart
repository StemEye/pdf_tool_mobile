import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/data/network/api_provider.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

class FilesBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<ApiProvider>()),
    );
  }
}

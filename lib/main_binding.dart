import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/data/network/api_interceptor.dart';
import 'data/network/api_provider.dart';

class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    initServices();
        Get.put(
      ApiInterceptor(
        maxRetries: 3,
        retryInterval: 1000,
      ),
      permanent: true,
    );
    Get.put<ApiProvider>(
      ApiProviderImpl(Get.find()),
      permanent: true,
    );

  }
}

void initServices() async {
  // LogUtil.logger?.d('starting services ...');
  // await Get.putAsync(() => Future.value(AppService()));
  // LogUtil.logger?.d('All services started...');
}

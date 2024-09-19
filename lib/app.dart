import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stemeye_pdf_mobile/routes/app_page.dart';
import 'package:stemeye_pdf_mobile/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      title: 'PDF Tool',
      theme: MyAppTheme.lightTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.approutes,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/modules/bottom_nav_bar/controller/navbar_controller.dart';
import 'package:stemeye_pdf_mobile/modules/bottom_nav_bar/view/widgets/custom_bttom_nav.dart';
import 'package:stemeye_pdf_mobile/modules/favorite_bottom/view/favorite_view.dart';
import 'package:stemeye_pdf_mobile/modules/file_bottom/view/files_view.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/view/home_view.dart';
import 'package:stemeye_pdf_mobile/modules/setting_bottom/view/setting_view.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.put(NavbarController());
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: navController.currentIndex.value,
          children: [HomeView(), FilesView(), FavoriteView(), SettingView()],
        );
      }),
      bottomNavigationBar: CustomBttomNav(),
    );
  }
}

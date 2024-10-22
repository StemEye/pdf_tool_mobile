import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stemeye_pdf_mobile/utils/helpers/helper_function.dart';

import '../../controller/navbar_controller.dart';

class CustomBttomNav extends StatelessWidget {
  CustomBttomNav({super.key});
  final List<String> itemNames = ['Home', 'File', 'Favorite', 'Settings'];
  final List<IconData> itemIcons = [
    Iconsax.home,
    Iconsax.folder,
    Icons.star_outline,
    Icons.settings_outlined
  ];
  @override
  Widget build(BuildContext context) {
    final NavbarController navController = Get.find();

    return Obx(() {
      return Container(
        color: Colors.blue.withOpacity(0.2),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              return GestureDetector(
                onTap: () => navController.changeTab(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.05,
                        width: MyHelperFunctions.screenWidth() * 0.17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: navController.currentIndex.value == index
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.transparent,
                        ),
                        //padding: EdgeInsets.all(8),
                        child: Icon(
                          itemIcons[index],
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      itemNames[index],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              );
            })),
      );
    });
  }
}

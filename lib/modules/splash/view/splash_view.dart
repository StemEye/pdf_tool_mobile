import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:stemeye_pdf_mobile/routes/app_routes.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAndToNamed(AppRoutes.HomeView);
    });

    return Scaffold(
      //backgroundColor: Colors.blueAccent.shade100,
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       SvgPicture.asset(
      //         'assets/convert_file/main_logo.svg',
      //       ),
      //       SizedBox(height: 10),
      //       Text(
      //         "PDF Wizard Tools",
      //         style: Theme.of(context)
      //             .textTheme
      //             .headlineLarge
      //             ?.copyWith(color: Colors.black),
      //       ),
      //     ],
      //   ),
      // ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'assets/project_import/splashback.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

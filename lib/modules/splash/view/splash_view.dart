import 'package:flutter/material.dart';
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
      body: Center(
        child: Container(
          child: Text(
            "Splash Screen",
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

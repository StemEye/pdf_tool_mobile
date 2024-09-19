import 'package:flutter/material.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key, required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(HomeController(_apiProvider));
    String sampleMarkDown = """ #Sample Markdown
    This is sample content """;
    return Scaffold(
      appBar: AppBar(
        title: Text("Markdown to PDF"),
      ),
      body: ElevatedButton(
          onPressed: () async {
           await controller.requestStoragePermission();

            controller.convertMarkDownToPdf(sampleMarkDown);
          },
          child: Text("markdown to pdf")),
    );
  }
}

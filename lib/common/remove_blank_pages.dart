import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

class RemoveBlankPages extends StatelessWidget {
  const RemoveBlankPages(
      {super.key, required this.conversionType, required this.filePath});
  final String conversionType;
  final String filePath;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final pageController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text("Remove Blank Pages"),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Picked File:${filePath.split('/').last}'),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     controller: pageController,
          //     keyboardType: TextInputType.phone,
          //     decoration: InputDecoration(
          //       hintText: "Enter pages you want to remove like 1, 2, 4",
          //     ),
          //   ),
          // ),
          ElevatedButton(
              onPressed: () {
                double whitePercent = 90;
                int threshold = 0;
                if (conversionType == 'remove blank pages') {
                  homeController.removeBlankPages(
                      filePath, threshold, whitePercent);
                }
              },
              child: Text('Remove password'))
        ])));
  }
}

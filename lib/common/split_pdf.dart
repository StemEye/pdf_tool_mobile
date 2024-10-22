import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/check_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

class SplitPdf extends StatelessWidget {
  const SplitPdf(
      {super.key, required this.conversionType, required this.filePath});
  final String conversionType;
  final String filePath;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    CheckboxController splitCheck = Get.put(CheckboxController());
    return Scaffold(
        appBar: AppBar(
          title: Text("Picked File"),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Picked File:${filePath.split('/').last}'),
                SizedBox(height: 10),
                Obx(() {
                  return Checkbox(
                      value: splitCheck.isChecked.value,
                      onChanged: (value) {
                        splitCheck.isChecked.value = value!;
                      });
                }),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          bool duplexMode = splitCheck.isChecked.value;
                          homeController.autoSplitPdf(filePath, duplexMode);
                        },
                        child: Text('Split')),
                  ],
                )
              ]),
        )));
  }
}

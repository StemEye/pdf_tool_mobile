import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

class CusUserInput extends StatelessWidget {
  const CusUserInput({super.key, required this.conversionType});
  final String conversionType;
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final inputController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: inputController,
                decoration: InputDecoration(
                    hintText: 'Enter $conversionType for conversion'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await homeController.requestStoragePermission();

                      if (conversionType == 'Markdown') {
                        homeController
                            .convertMarkDownToPdf(inputController.text);
                      } else if (conversionType == 'Url') {
                        homeController.convertUrlToPdf(inputController.text);
                      }
                    },
                    child: Text("$conversionType to pdf")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

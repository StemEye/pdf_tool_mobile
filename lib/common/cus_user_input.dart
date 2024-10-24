import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

import '../utils/constant/colors.dart';

class CusUserInput extends StatelessWidget {
  const CusUserInput({super.key, required this.conversionType});
  final String conversionType;
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final inputController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(conversionType.toUpperCase(),
            style: TextStyle(color: MyColors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: MyColors.black),
      ),
      body: Stack(children: [
        CustomPaint(
          painter: DiagonalBackgroundPainter(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.withOpacity(0.1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: inputController,
                        decoration: InputDecoration(
                            hintText: 'Enter $conversionType for conversion',
                            hintStyle: TextStyle(
                              color: MyColors.darkGrey,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(50)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.red.withOpacity(0.8), // Background color
                            side:
                                BorderSide(width: 0, color: Colors.transparent),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10), // Padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              //side: BorderSide.none // Rounded corners
                            ),
                          ),
                          onPressed: () async {
                            await homeController.requestStoragePermission();

                            if (conversionType == 'markdown') {
                              homeController
                                  .convertMarkDownToPdf(inputController.text);
                            } else if (conversionType == 'url') {
                              homeController
                                  .convertUrlToPdf(inputController.text);
                            }
                          },
                          child: Text("$conversionType to pdf")),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          return homeController.isLoading.value
              ? Center(
                  child: Container(
                    color: Colors.black54, // Semi-transparent overlay
                    child: Center(
                      child: SpinKitWaveSpinner(
                        color: Colors.blue,
                        size: 80,
                        waveColor: Colors.red,
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(); // Empty widget when not loading
        }),
      ]),
    );
  }
}

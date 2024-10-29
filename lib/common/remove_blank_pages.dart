import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/file_picker_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

import '../utils/helpers/helper_function.dart';

class RemoveBlankPages extends StatelessWidget {
  const RemoveBlankPages({
    super.key,
    required this.conversionType,
  });
  final String conversionType;
  //final String filePath;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final pageController = TextEditingController();
    FilePickerController filePickerController = Get.put(FilePickerController());
    return Scaffold(
        appBar: AppBar(
          title: Text("Remove Blank Pages"),
        ),
        body: Stack(children: [
          CustomPaint(
            painter: DiagonalBackgroundPainter(),
            child: Center(
                child: Container(
              height: MyHelperFunctions.screenHeight() * 0.4,
              width: MyHelperFunctions.screenWidth() * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.1)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          // Let the user pick a file
                          try {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                    allowedExtensions: ['pdf'],
                                    type: FileType.custom);
                            if (result != null && result.files.isNotEmpty) {
                              // Update file path in the controller
                              filePickerController
                                  .updateFilePath(result.files.single.path!);
                            } else {
                              Get.snackbar("Warning", "No file selected!");
                            }
                          } catch (e) {
                            Get.snackbar("Error", "Failed to pick file: $e");
                          }
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black),
                          child: Center(
                              child: Text(
                            "Upload File",
                            style: TextStyle(color: Colors.white),
                          )),
                        )),
                    // Observe the picked file path
                    SizedBox(height: 20),
                    Obx(() {
                      return Text(
                        'Picked File: ${filePickerController.pickedFilePath.value.isNotEmpty ? filePickerController.pickedFilePath.value.split('/').last : 'No file picked'}',
                        style: TextStyle(fontSize: 16),
                      );
                    }),
                    SizedBox(height: 15),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.red.withOpacity(0.8), // Background color
                          side: BorderSide(width: 0, color: Colors.transparent),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10), // Padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            //side: BorderSide.none // Rounded corners
                          ),
                        ),
                        onPressed: () {
                          String? filePath =
                              filePickerController.pickedFilePath.value;

                          if (filePath.isEmpty) {
                            // Show snackbar if no file is selected
                            Get.snackbar(
                                "Warning", "Please upload a file first!");
                            return; // Exit the function early
                          }

                          double whitePercent = 99.9;
                          int threshold = 10;
                          if (conversionType == 'remove blank pages') {
                            homeController.removeBlankPages(
                                filePath, threshold, whitePercent);
                          }
                        },
                        child: Text('Blank pages'))
                  ]),
            )),
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
        ]));
  }
}

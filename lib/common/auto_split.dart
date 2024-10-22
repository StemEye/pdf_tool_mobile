import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/file_picker_controller.dart';

import '../modules/home_bottom/controller/home_controller.dart';
import '../utils/helpers/helper_function.dart';

class AutoSplitPdf extends StatelessWidget {
  const AutoSplitPdf({
    super.key,
    required this.conversionType,
  });

  final String conversionType;

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final splitController = TextEditingController();
    FilePickerController filePickerController = Get.put(FilePickerController());

    return Scaffold(
        appBar: AppBar(
          title: Text(conversionType.toUpperCase()),
        ),
        body: CustomPaint(
          painter: DiagonalBackgroundPainter(),
          child: Center(
              child: Container(
            height: MyHelperFunctions.screenHeight() * 0.4,
            width: MyHelperFunctions.screenWidth() * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(0.1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          // Let the user pick a file
                          try {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
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
                            "Pick File",
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

                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: splitController,
                      decoration: InputDecoration(
                          hintText: conversionType == 'split by size'
                              ? "size in MB (e.g., '10MB')"
                              : conversionType == 'split by page count'
                                  ? "enetr number of pages (e.g., '5')"
                                  : "enetr number of pdf doc (e.g., '5')",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(50)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                          if (conversionType == 'split by size') {
                            int splitType = 0;
                            homeController.autoSplitPdf_1(
                                filePath, splitType, splitController.text);
                          } else if (conversionType == 'split by page count') {
                            int splitType = 1;
                            homeController.autoSplitPdf_1(
                                filePath, splitType, splitController.text);
                          } else if (conversionType == 'split by doc count') {
                            int splitType = 2;
                            homeController.autoSplitPdf_1(
                                filePath, splitType, splitController.text);
                          }
                        },
                        child: Text('$conversionType'))
                  ]),
            ),
          )),
        ));
  }
}

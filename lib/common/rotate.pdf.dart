import 'dart:io'; // For handling the file
import 'package:file_picker/file_picker.dart'; // For picking files
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/rotate_pdf_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // For displaying the PDF
import '../modules/home_bottom/controller/home_controller.dart'; // Import the controller
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/file_picker_controller.dart';

import '../utils/helpers/helper_function.dart'; // File picker controller

class Rotatepdf extends StatelessWidget {
  const Rotatepdf({super.key, required this.conversionType});
  final String conversionType;
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final rotateController = Get.put(RotatePdfController());
    final filePickerController = Get.put(FilePickerController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rotate PDF"),
      ),
      body: CustomPaint(
        painter: DiagonalBackgroundPainter(),
        child: Center(
          child: Container(
            height: MyHelperFunctions.screenHeight() * 0.5,
            width: MyHelperFunctions.screenWidth() * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(0.1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add File Picker Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GestureDetector(
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
                  ),

                  // Display the picked file's name
                  Obx(() {
                    return Text(
                      'Picked File: ${filePickerController.pickedFilePath.value.isNotEmpty ? filePickerController.pickedFilePath.value.split('/').last : 'No file picked'}',
                      style: TextStyle(fontSize: 16),
                    );
                  }),

                  // Display the PDF with rotation once a file is picked
                  SizedBox(height: 20),
                  Obx(() {
                    final filePath = filePickerController.pickedFilePath.value;
                    if (filePath.isNotEmpty && filePath.endsWith(".pdf")) {
                      return Expanded(
                        child: Transform.rotate(
                          angle: rotateController.rotationAngle.value *
                              3.1415927 /
                              180, // Convert degrees to radians
                          child: SfPdfViewer.file(
                              File(filePath)), // Display the PDF
                        ),
                      );
                    } else {
                      return const Text(
                        "No PDF selected or file is not a valid PDF",
                        style: TextStyle(fontSize: 12),
                      );
                    }
                  }),

                  // Rotation Buttons (Left, Rotate, Right)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Rotate Left Button
                        IconButton(
                          icon: const Icon(Icons.rotate_left),
                          onPressed: () {
                            rotateController
                                .rotateLeft(); // Rotate the PDF left
                          },
                        ),
                        // Rotate Button (API Call)
                        ElevatedButton(
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
                          onPressed: () {
                            final filePath =
                                filePickerController.pickedFilePath.value;
                            if (filePath.isNotEmpty &&
                                conversionType == 'rotate pdf') {
                              homeController.rotatePdf(
                                  filePath,
                                  rotateController.rotationAngle
                                      .value); // Call API to rotate the PDF
                            } else {
                              Get.snackbar("Error", "No file selected!");
                            }
                          },
                          child: const Text("Rotate"),
                        ),
                        // Rotate Right Button
                        IconButton(
                          icon: const Icon(Icons.rotate_right),
                          onPressed: () {
                            rotateController
                                .rotateRight(); // Rotate the PDF right
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

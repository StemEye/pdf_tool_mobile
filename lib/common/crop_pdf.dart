import 'dart:io';
import 'dart:math'; // For math functions like abs
import 'package:file_picker/file_picker.dart'; // For picking files
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // For displaying the PDF

import '../modules/home_bottom/controller/home_controller.dart';
import '../modules/home_bottom/controller/pdf_crop_controller.dart';
import '../modules/home_bottom/controller/file_picker_controller.dart'; // File picker controller

class CropPdf extends StatelessWidget {
  const CropPdf({super.key, required this.conversionType});
  final String conversionType;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final PdfCropController cropController = Get.put(PdfCropController());
    final FilePickerController filePickerController =
        Get.put(FilePickerController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop PDF"),
      ),
      body: CustomPaint(
        painter: DiagonalBackgroundPainter(),
        child: Stack(
          children: [
            // File Picker Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: GestureDetector(
                  onTap: () async {
                    // Let the user pick a file
                    try {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowedExtensions: ['pdf']);
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
            ),

            // Display the picked file's name
            Obx(() {
              return Text(
                'Picked File: ${filePickerController.pickedFilePath.value.isNotEmpty ? filePickerController.pickedFilePath.value.split('/').last : 'No file picked'}',
                style: const TextStyle(fontSize: 16),
              );
            }),

            // Display PDF and handle cropping functionality
            Obx(() {
              final filePath = filePickerController.pickedFilePath.value;
              if (filePath.isNotEmpty && filePath.endsWith(".pdf")) {
                return GestureDetector(
                  onTapDown: (details) {
                    // Set the start point on the first tap
                    cropController.startX.value = details.localPosition.dx;
                    cropController.startY.value = details.localPosition.dy;

                    // Reset the width and height for a fresh start
                    cropController.cropWidth.value = 0.0;
                    cropController.cropHeight.value = 0.0;
                  },
                  onPanUpdate: (details) {
                    // While dragging, adjust the crop area width and height based on movement
                    double currentX = details.localPosition.dx;
                    double currentY = details.localPosition.dy;

                    // Dynamically update width and height
                    cropController.cropWidth.value =
                        max((currentX - cropController.startX.value), 0);
                    cropController.cropHeight.value =
                        max((currentY - cropController.startY.value), 0);
                  },
                  child: SfPdfViewer.file(
                    File(filePath),
                  ),
                );
              } else {
                return const Center(
                    child: Text("No PDF selected or file is not a valid PDF."));
              }
            }),

            // Draw the selection rectangle
            Obx(() => Positioned(
                  left: cropController.startX.value,
                  top: cropController.startY.value,
                  child: Container(
                    width: cropController.cropWidth.value,
                    height: cropController.cropHeight.value,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                  ),
                )),

            // Button to save cropped PDF
            Positioned(
              bottom: 20,
              left: 20,
              child: ElevatedButton(
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
                onPressed: () async {
                  // Ensure that the cropping dimensions are set
                  double x = cropController.startX.value;
                  double y = cropController.startY.value;
                  double width = cropController.cropWidth.value;
                  double height = cropController.cropHeight.value;

                  // Make sure to check if width and height are valid
                  if (width > 0 && height > 0) {
                    final filePath = filePickerController.pickedFilePath.value;
                    if (filePath.isNotEmpty) {
                      if (conversionType == 'crop pdf') {
                        await homeController.cropPdf(
                            filePath, x, y, width, height);
                      } else {
                        Get.snackbar(
                            'Error', 'Please select a valid PDF file.');
                      }
                    } else {
                      Get.snackbar(
                          'Error', 'Please select a valid cropping area.');
                    }
                  }
                },
                child: const Text('Save Cropped PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

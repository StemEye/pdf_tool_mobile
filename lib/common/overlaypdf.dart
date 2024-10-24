import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/file_picker_controller.dart';
import 'package:stemeye_pdf_mobile/utils/constant/colors.dart';
import '../modules/home_bottom/controller/home_controller.dart'; // Adjust import if needed

class Overlaypdf extends StatelessWidget {
  const Overlaypdf({
    super.key,
    required this.conversionType,
  });
  final String conversionType;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final filePickerController =
        Get.find<FilePickerController>(); // Use Get.find instead of Get.put
    String? filePath = filePickerController.pickedFilePath.value;

    // Update the controller's file path with the passed filePath on initial load
    if (filePath == null || filePath.isEmpty) {
      filePickerController.updateFilePath(filePath);
    }

    Future<void> pickAnotherFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        // Update the controller with the new file path
        filePickerController.updateFilePath(result.files.single.path!);
      } else {
        Get.snackbar("Warning", "No file selected!");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Picked File"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the file name reactively using Obx
            ElevatedButton(
              onPressed: () async {
                // Let the user pick a file
                try {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom, allowedExtensions: ['pdf']);
                  if (result != null &&
                      result.files.isNotEmpty &&
                      result.files.single.path != null) {
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
              child: Text("Pick File"),
            ),
            // Observe the picked file path
            Obx(() {
              return Text(
                'Picked File: ${filePickerController.pickedFilePath.value.isNotEmpty ? filePickerController.pickedFilePath.value.split('/').last : 'No file picked'}',
                style: TextStyle(fontSize: 16),
              );
            }),
            SizedBox(height: 20),

            // Show either the button or the picked file name
            Obx(() {
              if (filePickerController.pickedFilePath.value == filePath) {
                // Show the button if no new file is picked
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.grey,
                      foregroundColor: MyColors.black),
                  onPressed: pickAnotherFile,
                  child: Text('Pick Another File'),
                );
              } else {
                // Show the picked file name in place of the button
                return Text(
                  'newFilePath: ${filePickerController.pickedFilePath.value.split('/').last}',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                );
              }
            }),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  String overlayMode =
                      'Sequential Overlay'; // Typo fixed from 'Squential'
                  List<int> counts = [0];
                  int overlayPosition = 0;
                  List<String> overlayFiles = [
                    filePickerController.pickedFilePath.value
                  ];
                  if (conversionType == 'overlay') {
                    homeController.overlayPdfs(
                        filePickerController.pickedFilePath.value,
                        overlayFiles,
                        overlayMode,
                        counts,
                        overlayPosition);
                  }
                },
                child: Text('Overlay PDF'))
          ],
        ),
      ),
    );
  }
}

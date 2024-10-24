import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/file_picker_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../modules/home_bottom/controller/home_controller.dart';
import '../utils/helpers/helper_function.dart';

class DeletePages extends StatelessWidget {
  const DeletePages({
    super.key,
    required this.conversionType,
  });
  final String conversionType;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final DeletePages = TextEditingController();
    FilePickerController filePickerController = Get.put(FilePickerController());

    return Scaffold(
        appBar: AppBar(
          title: Text('Delete Pages'.toUpperCase()),
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                // Let the user pick a file
                                try {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles();
                                  if (result != null &&
                                      result.files.isNotEmpty) {
                                    // Update file path in the controller
                                    filePickerController.updateFilePath(
                                        result.files.single.path!);
                                  } else {
                                    Get.snackbar(
                                        "Warning", "No file selected!");
                                  }
                                } catch (e) {
                                  Get.snackbar(
                                      "Error", "Failed to pick file: $e");
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
                          SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Picked File: ${filePickerController.pickedFilePath.value.isNotEmpty ? filePickerController.pickedFilePath.value.split('/').last : 'No file picked'}',
                                  style: TextStyle(fontSize: 16),
                                ),

                                SizedBox(height: 10),

                                // Display SfPdfViewer only if a PDF file is picked
                                if (filePickerController
                                        .pickedFilePath.isNotEmpty &&
                                    filePickerController.pickedFilePath
                                        .endsWith(".pdf"))
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    child: SfPdfViewer.file(File(
                                        filePickerController
                                            .pickedFilePath.value)),
                                  )
                                else if (filePickerController
                                    .pickedFilePath.isNotEmpty)
                                  Text(
                                    "The selected file is not a PDF.",
                                    style: TextStyle(color: Colors.red),
                                  ),
                              ],
                            );
                          }),

                          //Expanded(child: SfPdfViewer.file(File(filePath))),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: DeletePages,
                            decoration: InputDecoration(
                                hintText: "Enter page numbers like 1,3,5,6",
                                hintStyle: TextStyle(color: Colors.grey),
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
                                backgroundColor: Colors.red
                                    .withOpacity(0.8), // Background color
                                side: BorderSide(
                                    width: 0, color: Colors.transparent),
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
                                if (conversionType == 'delete pages') {
                                  homeController.deletePages(
                                      filePath, DeletePages.text);
                                }
                              },
                              child: Text('delete pages'))
                        ]),
                  ),
                ),
              ),
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

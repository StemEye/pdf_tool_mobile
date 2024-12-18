import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/file_picker_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';
import 'package:stemeye_pdf_mobile/utils/helpers/helper_function.dart';

class AddWatermark extends StatelessWidget {
  const AddWatermark({
    super.key,
    required this.conversionType,
  });

  final String conversionType;

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final watermarkController = TextEditingController();
    FilePickerController filePickerController = Get.put(FilePickerController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Watermark"),
      ),
      body: CustomPaint(
        painter: DiagonalBackgroundPainter(),
        child: Stack(
          children: [
            Center(
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

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: watermarkController,
                        decoration: InputDecoration(
                            hintText: "Enter watermark text",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(50)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),

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

                        if (conversionType == 'add watermark') {
                          String watermarkType = 'Text';
                          String watermarkText = watermarkController.text;
                          String watermarkImage = '';
                          String alphabet = 'Roman';
                          double fontSize = 30;
                          double rotation = 45;
                          double opacity = 50;
                          int widthSpacer = 50;
                          int heightSpacer = 50;
                          bool convertPDFToImage = true;

                          homeController.addWatermark(
                            filePath,
                            watermarkType,
                            watermarkText,
                            watermarkImage,
                            alphabet,
                            fontSize,
                            rotation,
                            opacity,
                            widthSpacer,
                            heightSpacer,
                            convertPDFToImage,
                          );
                        }
                      },
                      child: Text('$conversionType'),
                    ),
                  ],
                ),
              ),
            ),
            // Show progress indicator overlay
            Obx(() {
              return homeController.isLoading.value
                  ? Container(
                      color: Colors.black54, // Semi-transparent overlay
                      child: Center(
                        child: SpinKitWaveSpinner(
                          color: Colors.red,
                          size: 80,
                          waveColor: Colors.red.withOpacity(0.5),
                        ),
                      ),
                    )
                  : SizedBox.shrink(); // Empty widget when not loading
            }),
          ],
        ),
      ),
    );
  }
}

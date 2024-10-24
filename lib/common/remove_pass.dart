import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/file_picker_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';
import 'package:stemeye_pdf_mobile/utils/constant/colors.dart';

class RemovePass extends StatelessWidget {
  const RemovePass({super.key, required this.conversionType});
  final String conversionType;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final passwordController = TextEditingController();
    FilePickerController filePickerController = Get.put(FilePickerController());
    return Scaffold(
        appBar: AppBar(
          title: Text("Picked File"),
        ),
        body: Stack(children: [
          CustomPaint(
            painter: DiagonalBackgroundPainter(),
            child: Center(
                child: Container(
              height: 260,
              width: 260,
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
                            "Upload File",
                            style: TextStyle(color: Colors.white),
                          )),
                        )),
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
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: "Enter your password",
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
                          // Get the picked file path from the controller
                          String? filePath =
                              filePickerController.pickedFilePath.value;
                          if (conversionType == 'remove password') {
                            homeController.removePassword(
                                filePath, passwordController.text);
                          }
                        },
                        child: Text('Remove password'))
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

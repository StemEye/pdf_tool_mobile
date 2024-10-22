import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/drop_doen_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/file_picker_controller.dart';
import 'package:stemeye_pdf_mobile/utils/helpers/helper_function.dart';
import '../modules/home_bottom/controller/home_controller.dart';

class MergeMultipageIntoone extends StatelessWidget {
  const MergeMultipageIntoone({
    super.key,
    required this.conversionType,
  });

  //final String filePath;
  final String conversionType;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final pageController = TextEditingController();
    final dropdown = Get.put(DropdownController());
    FilePickerController filePickerController = Get.put(FilePickerController());
    String? filePath = filePickerController.pickedFilePath.value;

    // Define the dropdown items
    List<String> list = [
      'merge 2 pages',
      'merge 3 pages',
      'merge 4 pages',
      'merge 9 pages',
      'merge 16 pages'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Picked File"),
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
                SizedBox(height: 10),
                // Dropdown Button
                // Obx(() => DropdownButton<int>(
                //       items: items,
                //       // value: dropdown.selectedPages.value,
                //       // onChanged: (int? newValue) {
                //       //   if (newValue != null) {
                //       //     dropdown
                //       //         .updatePage(newValue); // Update the selected pages
                //       //   }
                //       },
                //     )),

                Obx(
                  () => SizedBox(
                    width: 250,
                    child: CustomDropdown<String>(
                      hintText: 'Select Pages to Merge',
                      items: list,
                      initialItem: dropdown.selectedLevel.value.isEmpty
                          ? null // Ensure hint is shown if no selection
                          : dropdown.selectedLevel.value,
                      onChanged: (value) {
                        if (value != null) {
                          log('Changing value to: $value'); // Import from dart:developer
                          dropdown.updateLevel(
                              value); // Update the controller with new value
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
                    //int pagepersheet = int.parse(pageController.text);
                    bool addBorder = true;
                    int pages = int.parse(dropdown.selectedPages.value);
                    if (conversionType == 'mul page into one') {
                      homeController.mergeMultiplePagesIntoOne(
                          filePath, pages, addBorder);
                    }
                  },
                  child: Text("Merge pages"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/file_picker_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/stamp_controller.dart';
import 'package:stemeye_pdf_mobile/utils/constant/colors.dart';
import 'package:stemeye_pdf_mobile/utils/helpers/helper_function.dart';

class AddStamp extends StatelessWidget {
  AddStamp({super.key, required this.conversionType});

  //final String filePath;
  final String conversionType;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final pageController = TextEditingController();
    final stampController = Get.put(StampController());
    final stamptextController = TextEditingController();
    final fontSizeController = TextEditingController();
    final fontOpacityController = TextEditingController();
    FilePickerController filePickerController = Get.put(FilePickerController());

    return Scaffold(
        appBar: AppBar(
          title: Text("Picked File"),
        ),
        body: Stack(children: [
          CustomPaint(
            painter: DiagonalBackgroundPainter(),
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Container(
                        width: MyHelperFunctions.screenWidth() * 0.8,
                        height: conversionType == 'add stamp'
                            ? MyHelperFunctions.screenHeight() * 0.84
                            : MyHelperFunctions.screenHeight() * 0.55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.withOpacity(0.1)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        // Let the user pick a file
                                        try {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles();
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
                                          Get.snackbar("Error",
                                              "Failed to pick file: $e");
                                        }
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.black),
                                        child: Center(
                                            child: Text(
                                          "Upload File",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      )),
                                  // Observe the picked file path
                                  SizedBox(height: 10),
                                  Obx(() {
                                    return Text(
                                      'Picked File: ${filePickerController.pickedFilePath.value.isNotEmpty ? filePickerController.pickedFilePath.value.split('/').last : 'No file picked'}',
                                      style: TextStyle(fontSize: 14),
                                    );
                                  }),
                                  if (conversionType == 'add stamp')
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0, top: 10),
                                      child: TextFormField(
                                        controller: pageController,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Enter page number like 1,2,4",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red
                                                        .withOpacity(0.5)),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.5)),
                                                borderRadius:
                                                    BorderRadius.circular(50))),
                                      ),
                                    ),
                                  Center(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            height: MyHelperFunctions
                                                    .screenHeight() *
                                                0.22,
                                            width: MyHelperFunctions
                                                    .screenWidth() *
                                                0.42,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: MyColors.grey,
                                            ),
                                            child: Center(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: List.generate(3,
                                                      (rowIndex) {
                                                    return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: List.generate(
                                                            3, (colIndex) {
                                                          int number =
                                                              rowIndex * 3 +
                                                                  colIndex +
                                                                  1;
                                                          return Obx(() {
                                                            // Check if this number is selected
                                                            bool isSelected =
                                                                stampController
                                                                        .selectedNumber
                                                                        .value ==
                                                                    number;

                                                            return GestureDetector(
                                                              onTap: () {
                                                                stampController
                                                                    .selectNumber(
                                                                        number); // Update selected number
                                                              },
                                                              child: Container(
                                                                height: MyHelperFunctions
                                                                        .screenHeight() *
                                                                    0.050,
                                                                width: MyHelperFunctions
                                                                        .screenWidth() *
                                                                    0.1,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: isSelected
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.4),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                        '$number')),
                                                              ),
                                                            );
                                                          });
                                                        }));
                                                  })),
                                            )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: TextFormField(
                                      controller: stamptextController,
                                      decoration: InputDecoration(
                                          hintText:
                                              conversionType == 'add stamp'
                                                  ? "Enter stamp text"
                                                  : 'Enter custom text',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red
                                                      .withOpacity(0.5)),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (conversionType == 'add stamp')
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: TextFormField(
                                        controller: fontSizeController,
                                        decoration: InputDecoration(
                                            hintText: "Enter font size",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red
                                                        .withOpacity(0.5)),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.5)),
                                                borderRadius:
                                                    BorderRadius.circular(50))),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (conversionType == 'add stamp')
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: TextFormField(
                                        controller: fontOpacityController,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Enter opacity of stamp text",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red
                                                        .withOpacity(0.5)),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.5)),
                                                borderRadius:
                                                    BorderRadius.circular(50))),
                                      ),
                                    ),

                                  if (conversionType == 'add stamp')
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Pick the color'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ColorPicker(
                                                      pickerColor:
                                                          stampController
                                                              .selectedColor
                                                              .value,
                                                      onColorChanged:
                                                          (Color color) {
                                                        stampController
                                                            .selectColor(color);
                                                      },
                                                      showLabel: true,
                                                      pickerAreaHeightPercent:
                                                          0.8,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Select'))
                                                  ],
                                                );
                                              });
                                        },
                                        child: Obx(() {
                                          return Container(
                                            width: 100,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: stampController
                                                  .selectedColor.value,
                                            ), // Show selected color
                                            child: Center(
                                                child: Text("Selected Color",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium
                                                        ?.copyWith(
                                                            color: MyColors
                                                                .white))),
                                          );
                                        }),
                                      ),
                                    ),
                                  SizedBox(height: 15),
                                  Center(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red
                                              .withOpacity(
                                                  0.8), // Background color
                                          side: BorderSide(
                                              width: 0,
                                              color: Colors.transparent),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10), // Padding
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            //side: BorderSide.none // Rounded corners
                                          ),
                                        ),
                                        onPressed: () {
                                          String? filePath =
                                              filePickerController
                                                  .pickedFilePath.value;
                                          if (conversionType == 'add stamp') {
                                            String stampType = 'Text';
                                            String pageNumbers =
                                                pageController.text;
                                            String stampImage = '';
                                            String alphabet = 'Roman';
                                            double rotation = 0;
                                            double fontsize = double.parse(
                                                fontSizeController.text);
                                            double opacity = double.parse(
                                                fontOpacityController.text);
                                            int position = stampController
                                                .selectedNumber.value;
                                            double overrideX = -1;
                                            double overrideY = -1;
                                            String customMargin = 'Medium';

                                            String customColorHex = colorToHex(
                                                stampController
                                                    .selectedColor.value);

                                            homeController.addStamp(
                                                filePath,
                                                pageNumbers,
                                                stampType,
                                                stamptextController.text,
                                                stampImage,
                                                alphabet,
                                                fontsize,
                                                rotation,
                                                opacity,
                                                position,
                                                overrideX,
                                                overrideY,
                                                customMargin,
                                                customColorHex);
                                          } else if (conversionType ==
                                              'add page num') {
                                            String? pageNumbers = '';
                                            String customMargin = 'Medium';
                                            int position = stampController
                                                .selectedNumber.value;
                                            int startingNumber = 1;
                                            String? pagesToNumber = '';
                                            String? customText =
                                                stamptextController.text;
                                            homeController.addPageNumber(
                                                filePath,
                                                pageNumbers,
                                                customMargin,
                                                position,
                                                startingNumber,
                                                pagesToNumber,
                                                customText);
                                          }
                                        },
                                        child: Text(
                                            conversionType == 'add stamp'
                                                ? "Add Stamp"
                                                : "Add Page Number")),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ))),
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

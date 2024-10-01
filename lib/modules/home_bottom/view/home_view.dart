import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/add_password.dart';
import 'package:stemeye_pdf_mobile/common/add_watermark.dart';
import 'package:stemeye_pdf_mobile/common/compress_pdf.dart';
import 'package:stemeye_pdf_mobile/common/cus_user_input.dart';
import 'package:stemeye_pdf_mobile/common/picked_file.dart';
import 'package:stemeye_pdf_mobile/common/remove_blank_pages.dart';
import 'package:stemeye_pdf_mobile/common/user_add_file.dart';
import 'package:stemeye_pdf_mobile/data/network/api_interceptor.dart';
import 'package:stemeye_pdf_mobile/data/network/api_provider.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';
import 'package:stemeye_pdf_mobile/utils/constant/colors.dart';
import 'package:stemeye_pdf_mobile/utils/helpers/helper_function.dart';

class HomeView extends StatelessWidget {
  HomeView({
    super.key,
  });
  //final HomeController controller;
  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(HomeController(ApiProviderImpl(ApiInterceptor())));
    // String sampleMarkDown = """ #Sample Markdown
    // This is sample content """;
    return Scaffold(
        appBar: AppBar(
          title: Text("Pdf Tools"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(CusUserInput(
                        conversionType: 'Markdown',
                      )),
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Markdown to pdf")),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.to(CusUserInput(
                        conversionType: 'Url',
                      )),
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Url to pdf")),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          Get.to(PickedfileScreen(
                            filePath: result.files.single.path!,
                            conversionType: 'pdf to xml',
                          ));
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Pdf to xml")),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          Get.to(PickedfileScreen(
                            filePath: result.files.single.path!,
                            conversionType: 'pdf to word',
                          ));
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Pdf to word")),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        Get.to(PickedfileScreen(
                          filePath: result.files.single.path!,
                          conversionType: 'pdf to rttext',
                        ));
                      }
                    },
                    child: Container(
                      height: MyHelperFunctions.screenHeight() * 0.15,
                      width: MyHelperFunctions.screenWidth() * 0.4,
                      color: MyColors.grey,
                      child: Center(child: Text("Pdf to RtText")),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        Get.to(PickedfileScreen(
                          filePath: result.files.single.path!,
                          conversionType: 'pdf to presentation',
                        ));
                      }
                    },
                    child: Container(
                      height: MyHelperFunctions.screenHeight() * 0.15,
                      width: MyHelperFunctions.screenWidth() * 0.4,
                      color: MyColors.grey,
                      child: Center(child: Text("Pdf to Presentation")),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        Get.to(PickedfileScreen(
                          filePath: result.files.single.path!,
                          conversionType: 'pdf to pdfa',
                        ));
                      }
                    },
                    child: Container(
                      height: MyHelperFunctions.screenHeight() * 0.15,
                      width: MyHelperFunctions.screenWidth() * 0.4,
                      color: MyColors.grey,
                      child: Center(child: Text("Pdf to Pdfa")),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        Get.to(PickedfileScreen(
                          filePath: result.files.single.path!,
                          conversionType: 'pdf to image',
                        ));
                      }
                    },
                    child: Container(
                      height: MyHelperFunctions.screenHeight() * 0.15,
                      width: MyHelperFunctions.screenWidth() * 0.4,
                      color: MyColors.grey,
                      child: Center(child: Text("Pdf to Image")),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        Get.to(PickedfileScreen(
                          filePath: result.files.single.path!,
                          conversionType: 'pdf to csv',
                        ));
                      }
                    },
                    child: Container(
                      height: MyHelperFunctions.screenHeight() * 0.15,
                      width: MyHelperFunctions.screenWidth() * 0.4,
                      color: MyColors.grey,
                      child: Center(child: Text("Pdf to Csv")),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        Get.to(PickedfileScreen(
                          filePath: result.files.single.path!,
                          conversionType: 'html to pdf',
                        ));
                      }
                    },
                    child: Container(
                      height: MyHelperFunctions.screenHeight() * 0.15,
                      width: MyHelperFunctions.screenWidth() * 0.4,
                      color: MyColors.grey,
                      child: Center(child: Text("Html to Pdf")),
                    ),
                  )
                ]),
                SizedBox(height: 10),
                Row(children: [
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        Get.to(PickedfileScreen(
                          filePath: result.files.single.path!,
                          conversionType: 'file to pdf',
                        ));
                      }
                    },
                    child: Container(
                      height: MyHelperFunctions.screenHeight() * 0.15,
                      width: MyHelperFunctions.screenWidth() * 0.4,
                      color: MyColors.grey,
                      child: Center(child: Text("File to Pdf")),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        Get.to(PickedfileScreen(
                          filePath: result.files.single.path,
                          conversionType: 'pdf to html',
                        ));
                      }
                    },
                    child: Container(
                      height: MyHelperFunctions.screenHeight() * 0.15,
                      width: MyHelperFunctions.screenWidth() * 0.4,
                      color: MyColors.grey,
                      child: Center(child: Text("Pdf to Html")),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  GestureDetector(
                    onTap: () async {
                      print('File selection initiated.');
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              allowMultiple: true,
                              allowCompression: true,
                              compressionQuality: 30,
                              type: FileType.any);
                      if (result != null && result.files.isNotEmpty) {
                        List<String> imagePaths =
                            result.files.map((file) => file.path!).toList();

                        print("Files selected: ${result.files.length} files.");

                        // Logging the selected file paths

                        Get.to(PickedfileScreen(
                          imagePaths: imagePaths,
                          conversionType: 'images to pdf',
                        ));
                      } else {
                        print("No files selected or result is null.");
                        Get.snackbar(
                            'Info', 'No files selected. Please try again.');
                      }
                    },
                    child: Container(
                      height: MyHelperFunctions.screenHeight() * 0.15,
                      width: MyHelperFunctions.screenWidth() * 0.4,
                      color: MyColors.grey,
                      child: Center(child: Text("Images to Pdf")),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null && result.files.single.path != null) {
                        Get.to(PickedfileScreen(
                          filePath: result.files.single.path,
                          conversionType: 'sanitize pdf',
                        ));
                      } else {
                        // Inform user if no file was picked
                        Get.snackbar(
                            'Error', 'No file selected. Please pick a PDF.');
                      }
                    },
                    child: Container(
                      height: MyHelperFunctions.screenHeight() * 0.15,
                      width: MyHelperFunctions.screenWidth() * 0.4,
                      color: MyColors.grey,
                      child: Center(child: Text("Sanitize Your Pdf")),
                    ),
                  ),
                ]),
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null &&
                            result.files.single.path != null) {
                          Get.to(UserAddFile(
                            filePath: result.files.single.path ?? '',
                            conversionType: 'remove password',
                          ));
                        } else {
                          // Inform user if no file was picked
                          Get.snackbar(
                              'Error', 'No file selected. Please pick a PDF.');
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("remove password")),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null &&
                            result.files.single.path != null) {
                          Get.to(PickedfileScreen(
                            filePath: result.files.single.path ?? '',
                            conversionType: 'remove certificate',
                          ));
                        } else {
                          // Inform user if no file was picked
                          Get.snackbar(
                              'Error', 'No file selected. Please pick a PDF.');
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("remove certificate")),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null &&
                            result.files.single.path != null) {
                          Get.to(PickedfileScreen(
                            filePath: result.files.single.path ?? '',
                            conversionType: 'pdf info',
                          ));
                        } else {
                          // Inform user if no file was picked
                          Get.snackbar(
                              'Error', 'No file selected. Please pick a PDF.');
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Get Pdf Info")),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null &&
                            result.files.single.path != null) {
                          Get.to(AddPassword(
                            filePath: result.files.single.path ?? '',
                            conversionType: 'protect pdf',
                          ));
                        } else {
                          // Inform user if no file was picked
                          Get.snackbar(
                              'Error', 'No file selected. Please pick a PDF.');
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Secure Pdf File")),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          Get.to(PickedfileScreen(
                            filePath: result.files.single.path ?? '',
                            conversionType: 'repair pdf',
                          ));
                        } else {
                          // Inform user if no file was picked
                          Get.snackbar(
                              'Error', 'No file selected. Please pick a PDF.');
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Repair Pdf File")),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null &&
                            result.files.single.path != null &&
                            result.files.single.path!.isNotEmpty) {
                          print(result.files.single.path);

                          Get.to(AddWatermark(
                            filePath: result.files.single.path ?? '',
                            conversionType: 'add watermark',
                          ));
                        } else {
                          // Inform user if no file was picked
                          Get.snackbar(
                              'Error', 'No file selected. Please pick a PDF.');
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Add Watermark")),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null &&
                            result.files.single.path != null) {
                          Get.to(RemoveBlankPages(
                            filePath: result.files.single.path ?? '',
                            conversionType: 'remove blank pages',
                          ));
                        } else {
                          // Inform user if no file was picked
                          Get.snackbar(
                              'Error', 'No file selected. Please pick a PDF.');
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Remove Blank Pages")),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null &&
                            result.files.single.path != null) {
                          Get.to(PickedfileScreen(
                            filePath: result.files.single.path ?? '',
                            conversionType: 'flatten pdf',
                          ));
                        } else {
                          // Inform user if no file was picked
                          Get.snackbar(
                              'Error', 'No file selected. Please pick a PDF.');
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Flatten Pdf")),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf']);
                        if (result != null &&
                            result.files.single.path != null) {
                          Get.to(PickedfileScreen(
                            filePath: result.files.single.path ?? '',
                            conversionType: 'extract images',
                          ));
                        } else {
                          // Inform user if no file was picked
                          Get.snackbar(
                              'Error', 'No file selected. Please pick a PDF.');
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Extract Images")),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf']);
                        if (result != null &&
                            result.files.single.path != null) {
                          Get.to(CompressPdf(
                            filePath: result.files.single.path ?? '',
                            conversionType: 'compress pdf',
                          ));
                        } else {
                          // Inform user if no file was picked
                          Get.snackbar(
                              'Error', 'No file selected. Please pick a PDF.');
                        }
                      },
                      child: Container(
                        height: MyHelperFunctions.screenHeight() * 0.15,
                        width: MyHelperFunctions.screenWidth() * 0.4,
                        color: MyColors.grey,
                        child: Center(child: Text("Compress Pdf")),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

// ElevatedButton(
//           onPressed: () async {
//             await controller.requestStoragePermission();

//             controller.convertMarkDownToPdf(sampleMarkDown);
//           },
//           child: Text("markdown to pdf")),

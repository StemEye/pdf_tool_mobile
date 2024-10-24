import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_background.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/file_picker_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';
import 'package:stemeye_pdf_mobile/utils/constant/colors.dart';

class PickedfileScreen extends StatelessWidget {
  const PickedfileScreen({
    super.key,
    required this.conversionType,
    this.imagePaths,
  });

  final String conversionType;
  final List<String>? imagePaths;

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final FilePickerController filePickerController =
        Get.put(FilePickerController());

    return Scaffold(
      appBar: AppBar(
        title: Text(conversionType.toUpperCase(),
            style: TextStyle(color: MyColors.black)),
        backgroundColor: Colors.blue.withOpacity(0.2),
        iconTheme: IconThemeData(color: MyColors.black),
      ),
      body: Stack(children: [
        CustomPaint(
          painter: DiagonalBackgroundPainter(),
          child: Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.2)),
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
                      ),
                    ),
                    // Observe the picked file path
                    SizedBox(height: 30),
                    Obx(() {
                      return Text(
                        'Picked File: ${filePickerController.pickedFilePath.value.isNotEmpty ? filePickerController.pickedFilePath.value.split('/').last : 'No file picked'}',
                        style: TextStyle(fontSize: 16, color: MyColors.black),
                      );
                    }),
                    SizedBox(height: 20),
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
                      onPressed: () async {
                        // Request permissions
                        await homeController.requestStoragePermission();

                        // Get the picked file path from the controller
                        String? filePath =
                            filePickerController.pickedFilePath.value;
                        if (filePath.isNotEmpty) {
                          try {
                            switch (conversionType) {
                              case 'pdf to xml':
                                await homeController.convertPdfToXml(filePath);
                                break;
                              case 'pdf to word':
                                await homeController.convertPdfToWord(
                                    filePath, 'docx');
                                break;
                              case 'pdf to rttext':
                                await homeController.covertPdfToRtText(
                                    filePath, 'rtf');
                                break;
                              case 'pdf to presentation':
                                await homeController.covertPdfToPresentation(
                                    filePath, 'pptx');
                                break;
                              case 'pdf to pdfa':
                                await homeController.covertPdfToPdfa(
                                    filePath, 'pdf');
                                break;
                              case 'pdf to image':
                                await homeController.covertToImage(
                                    filePath, 'png', 'single', 'color', '300');
                                break;
                              case 'pdf to csv':
                                int pageId = 1;
                                await homeController.covertPdfToCsv(
                                    filePath, pageId);
                                break;
                              case 'html to pdf':
                                await homeController.covertHtmlToPdf(filePath);
                                break;
                              case 'file to pdf':
                                await homeController.covertFileToPdf(filePath);
                                break;
                              case 'pdf to html':
                                await homeController.convertPdftoHtml(filePath);
                                break;
                              case 'images to pdf':
                                if (imagePaths != null) {
                                  await homeController.convertToPdf(
                                      imagePaths!, 'fit', 'color', true);
                                }
                                break;
                              case 'sanitize pdf':
                                bool removeJavaScript = true;
                                bool removeEmbeddedFiles = true;
                                bool removeMetadata = true;
                                bool removeLinks = true;
                                bool removeFonts = false;
                                await homeController.sanitizePDF(
                                    filePath,
                                    removeJavaScript,
                                    removeEmbeddedFiles,
                                    removeMetadata,
                                    removeLinks,
                                    removeFonts);
                                break;
                              case 'remove certificate':
                                await homeController
                                    .removeCertSignPDF(filePath);
                                break;
                              case 'pdf info':
                                await homeController.getPdfInfo(filePath);
                                break;
                              case 'repair pdf':
                                await homeController.repairPdf(filePath);
                                break;
                              case 'flatten pdf':
                                bool flattenOnlyForms = false;
                                await homeController.flattenPdf(
                                    filePath, flattenOnlyForms);
                                break;
                              case 'extract images':
                                String imageFormat = 'png';
                                await homeController.extractImage(
                                    filePath, imageFormat);
                                break;
                              case 'auto rename':
                                await homeController.autoRename(filePath);
                                break;
                              case 'remove images':
                                await homeController.removeImages(filePath);
                                break;
                              case 'pdf to single page':
                                await homeController.pdfToSinglePage(filePath);
                                break;
                              default:
                                Get.snackbar(
                                    "Error", "Unknown conversion type!");
                            }
                          } catch (e) {
                            Get.snackbar("Error", "Conversion failed: $e");
                          }
                        } else {
                          Get.snackbar("Error", "No file picked!");
                        }
                      },
                      child: Text(
                        '$conversionType',
                        style: TextStyle(color: MyColors.white),
                      ),
                    ),
                  ]),
            ),
          ),
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
      ]),
    );
  }
}

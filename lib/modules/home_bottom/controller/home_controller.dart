import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stemeye_pdf_mobile/data/network/api_provider.dart';

class HomeController extends GetxController {
  ApiProvider _apiProvider;
  HomeController(this._apiProvider);

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var result = await Permission.storage.request();
      if (result.isGranted) {
        GetSnackBar(title: 'Sucess', message: 'Storage permission granted');
      } else {
        print("Storage permission denied");
      }
    }
  }

// Function to request storage permissions
  // Future<void> requestGalleryPermission() async {
  //   var status = await Permission.photos.status;
  //   if (!status.isGranted) {
  //     var result = await Permission.photos.request();
  //     if (result.isGranted) {
  //       GetSnackBar(title: 'Sucess', message: 'Gallery permission granted');
  //     } else {
  //       print("Gallery permission denied");
  //       Get.snackbar('Permission Denied',
  //           'Gallery permission is required to pick files.');
  //     }
  //   }
  // }

  Future<dynamic> convertMarkDownToPdf(String markdown) async {
    try {
      final response = await _apiProvider.markdownToPdf(markdown);
      if (response.statusCode == 200) {
        print("Pdf genrated successfully");
        print("Response data type: ${response.data.runtimeType}");

        if (response.data is List<int>) {
          //final pdfBytes = utf8.encode(response.data);
          print("Pdf genrated successfully");

          await FileSaver.instance.saveAs(
              name: "genrated_pdf",
              bytes: Uint8List.fromList(response.data),
              ext: "pdf",
              mimeType: MimeType.pdf);
          Get.snackbar('Success', 'PDF saved successfully');
        } else {
          print("Response data is not in Uint8List format");
        }
        //Get.snackbar('Success', 'Pdf Saved successfully');
      } else {
        print("Something went wrong");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting markdown to PDF: $e');
    }
  }

  Future<dynamic> convertUrlToPdf(String url) async {
    try {
      final response = await _apiProvider.urlToPdf(url);

      print('Response type: ${response.runtimeType}');
      print('Response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        print("PDF generated successfully");

        if (response.data is List<int>) {
          //final pdfBytes = utf8.encode(response.data);
          print("Pdf genrated successfully");

          await FileSaver.instance.saveAs(
              name: "genrated_pdf",
              bytes: Uint8List.fromList(response.data),
              ext: "pdf",
              mimeType: MimeType.pdf);
          Get.snackbar('Success', 'PDF saved successfully');
        } else {
          print("Response data is not in Uint8List format");
        }
        //Get.snackbar('Success', 'Pdf Saved successfully');
      } else {
        print("Something went wrong");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting url to PDF: $e');
    }
  }

  Future<dynamic> convertPdfToXml(String pdfBytes) async {
    try {
      // // Read the PDF file
      // final file = File(filePath);
      // if (!await file.exists()) {
      //   Get.snackbar('Error', 'File does not exist');
      //   return;
      // }
      //final pdfBytes = await file.readAsBytes();
      print("pdfFilePath: $pdfBytes");
      final response = await _apiProvider.processPdfToXML(pdfBytes);
      print('Response type: ${response.runtimeType}');
      print('Response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        print("Xml generated successfully");

        if (response.data is List<int>) {
          //final xmlBytes = utf8.encode(response.data);
          // print("Xml genrated successfully");

          await FileSaver.instance.saveAs(
              name: "genrated_Xml",
              bytes: Uint8List.fromList(response.data),
              ext: "xml",
              mimeType: MimeType.other);

          Get.snackbar('Success', 'xml saved successfully');
        } else {
          print("Response data is not in Uint8List format");
        }
        //Get.snackbar('Success', 'Pdf Saved successfully');
      } else {
        print("Something went wrong");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting url to PDF: $e');
    }
  }

  Future<dynamic> convertPdfToWord(String pdfBytes, String outputFormat) async {
    try {
      print("pdfFilePath: $pdfBytes");
      final response =
          await _apiProvider.processPdfToWord(pdfBytes, outputFormat);

      print('Response type: ${response.runtimeType}');
      print('Response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        print("Word document generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          await FileSaver.instance.saveAs(
            name: 'generated_docx',
            bytes: Uint8List.fromList(response.data),
            ext: 'docx',
            mimeType: MimeType.other,
          );

          Get.snackbar('Success', 'Word document saved successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    }
  }

  Future<dynamic> covertPdfToRtText(
      String pdfBytes, String outputFormat) async {
    try {
      print("pdfFilePath: $pdfBytes");
      final response =
          await _apiProvider.processPdfToRTForTXT(pdfBytes, outputFormat);

      print('Response type: ${response.runtimeType}');
      print('Response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        print("document generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          await FileSaver.instance.saveAs(
            name: 'genrated_rttext',
            bytes: Uint8List.fromList(response.data),
            ext: 'rtf',
            mimeType: MimeType.other,
          );

          Get.snackbar('Success', 'document saved successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    }
  }

  Future<dynamic> covertPdfToPresentation(
      String pdfBytes, String outputFormat) async {
    try {
      print("pdfFilePath: $pdfBytes");
      final response =
          await _apiProvider.processPdfToPresentation(pdfBytes, outputFormat);

      print('Response type: ${response.runtimeType}');
      print('Response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        print("Presentation generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          await FileSaver.instance.saveAs(
            name: 'genrated_presentation',
            bytes: Uint8List.fromList(response.data),
            ext: 'pptx',
            mimeType: MimeType.other,
          );

          Get.snackbar('Success', 'document saved successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    }
  }

  Future<dynamic> covertPdfToPdfa(String pdfBytes, String outputFormat) async {
    try {
      print("pdfFilePath: $pdfBytes");
      final response = await _apiProvider.pdfToPdfA(pdfBytes, outputFormat);

      if (response.statusCode == 200) {
        print("Presentation generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          await FileSaver.instance.saveAs(
            name: 'genrated_pdfa',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Get.snackbar('Success', 'document saved successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    }
  }

  Future<dynamic> covertToImage(String pdfBytes, String imageFormat,
      String singleOrMultiple, String colorType, String dpi) async {
    try {
      final response = await _apiProvider.convertToImage(
          pdfBytes, imageFormat, singleOrMultiple, colorType, dpi);

      if (response.statusCode == 200) {
        print("Image generated successfully");

        // if (response.data is List<int>) {
        //   print(
        //       'Received valid binary data with length: ${response.data.length}');

        await FileSaver.instance.saveAs(
          name: 'genrated_img',
          bytes: Uint8List.fromList(response.data),
          ext: 'png',
          mimeType: MimeType.png,
        );

        Get.snackbar('Success', 'document saved successfully');
        //  else {
        //   print("Response data is not in expected binary format");
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    }
  }

  Future<dynamic> covertPdfToCsv(String pdfBytes, int pageId) async {
    try {
      print("pdfFilePath: $pdfBytes");
      final response = await _apiProvider.pdfToCsv(pdfBytes, pageId);

      if (response.statusCode == 200) {
        print("Csv file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          await FileSaver.instance.saveAs(
            name: 'genrated_csv',
            bytes: Uint8List.fromList(response.data),
            ext: 'csv',
            mimeType: MimeType.text,
          );

          Get.snackbar('Success', 'document saved successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    }
  }

  Future<dynamic> covertHtmlToPdf(String htmlBytes) async {
    try {
      print("pdfFilePath: $htmlBytes");
      final response = await _apiProvider.htmlToPdf(htmlBytes);

      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Get.snackbar('Success', 'document saved successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    }
  }

  Future<dynamic> covertFileToPdf(String fileBytes) async {
    try {
      print("pdfFilePath: $fileBytes");
      final response = await _apiProvider.processFileToPDF(fileBytes);

      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Get.snackbar('Success', 'document saved successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    }
  }

  Future<dynamic> convertPdftoHtml(String pdfBytes) async {
    try {
      print("pdfFilePath: $pdfBytes");
      final response = await _apiProvider.processPdfToHTML(pdfBytes);

      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          await FileSaver.instance.saveAs(
            name: 'genrated_html',
            bytes: Uint8List.fromList(response.data),
            ext: 'html',
            mimeType: MimeType.other,
          );

          Get.snackbar('Success', 'document saved successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    }
  }

  Future<dynamic> convertToPdf(List<String> imageBytes, String fitOption,
      String colorType, bool autoRotate) async {
    try {
      final response = await _apiProvider.convertToPdf(
          imageBytes, fitOption, colorType, autoRotate);

      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Get.snackbar('Success', 'document saved successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

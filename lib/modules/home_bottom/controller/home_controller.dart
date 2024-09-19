import 'dart:convert';
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

  Future<void> convertMarkDownToPdf(String markdown) async {
    try {
      final response = await _apiProvider.markdownToPdf(markdown);
      if (response.statusCode == 200) {
        print("Pdf genrated successfully");
        print("Response data type: ${response.data.runtimeType}");

        if (response.data is String) {
          final pdfBytes = utf8.encode(response.data);
          print("Pdf genrated successfully");

          await FileSaver.instance.saveAs(
              name: "genrated_pdf",
              bytes: Uint8List.fromList(pdfBytes),
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

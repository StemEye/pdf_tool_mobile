import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stemeye_pdf_mobile/data/network/api_provider.dart';

import '../../../common/custom/conversion_history.dart';

class HomeController extends GetxController {
  ApiProvider _apiProvider;
  HomeController(this._apiProvider);

  RxBool isLoading = false.obs;
  var filePath = ''.obs;

  //RxList<Conversion> completedConversions = <Conversion>[].obs;
  var conversionHistory = <Conversion>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadConversionHistory();
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

  // Load conversion history from shared preferences
  Future<void> loadConversionHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyJson = prefs.getString('conversionHistory');

    if (historyJson != null) {
      print("Loading conversion history: $historyJson"); // Debug print

      List<dynamic> historyList = jsonDecode(historyJson);
      conversionHistory.value = historyList
          .map((item) => Conversion.fromJson(
              item)) // Ensure Conversion class has this method
          .toList()
          .cast<Conversion>();
      print("Loaded conversions: ${conversionHistory.length}"); // Debug print
    } else {
      print("No conversion history found."); // Debug print
    }
  }

  // Add a new conversion to the history and save it to shared preferences
  Future<void> addConversion(Conversion conversion) async {
    conversionHistory.add(conversion); // Add to observable list
    print('Adding conversion: ${conversion.toJson()}'); // Debug print

    // Save to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> historyList =
        conversionHistory.map((item) => item.toJson()).toList();
    await prefs.setString('conversionHistory', jsonEncode(historyList));
    print('Conversion history saved: $historyList'); // Debug print
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
      isLoading.value = true;

      final response = await _apiProvider.markdownToPdf(markdown);
      if (response.statusCode == 200) {
        print("Pdf genrated successfully");
        print("Response data type: ${response.data.runtimeType}");
        if (response.data is List<int>) {
          //final pdfBytes = utf8.encode(response.data);
          print("Pdf genrated successfully");

          String? filePath = await FileSaver.instance.saveAs(
            name: "markdown",
            bytes: Uint8List.fromList(response.data),
            ext: "pdf",
            mimeType: MimeType.pdf,
          );

          // completedConversions.add(Conversion(
          //   filePath: 'genrated',
          //   conversionType: 'markdown to pdf',
          //   timestamp: DateTime.now().toIso8601String(),
          // ));

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'markdown',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> convertUrlToPdf(String url) async {
    try {
      isLoading.value = true;

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/generated.docx'; // Full path
      print("pdfFilePath: $filePath");
      final response = await _apiProvider.urlToPdf(url);

      if (response.statusCode == 200) {
        print("PDF generated successfully");
        if (response.data is List<int>) {
          //final pdfBytes = utf8.encode(response.data);
          print("Pdf genrated successfully");
          String? filePath = await FileSaver.instance.saveAs(
              name: "url",
              bytes: Uint8List.fromList(response.data),
              ext: "pdf",
              mimeType: MimeType.pdf);

          // completedConversions.add(Conversion(
          //   filePath: filePath!,
          //   conversionType: 'url',
          //   timestamp: DateTime.now().toIso8601String(),
          // ));
          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'url',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);
          Get.snackbar('Success', 'PDF saved successfully');
          final result = await OpenFile.open(filePath);
          print('Open File Result: ${result.message}');
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> convertPdfToXml(String pdfBytes) async {
    try {
      isLoading.value = true;

      print("pdfFilePath: $pdfBytes");
      final response = await _apiProvider.processPdfToXML(pdfBytes);

      if (response.statusCode == 200) {
        print("Xml generated successfully");

        if (response.data is List<int>) {
          //String fileName = "pdftoxml";
          String? filePath = await FileSaver.instance.saveAs(
              name: "genrated",
              bytes: Uint8List.fromList(response.data),
              ext: "xml",
              mimeType: MimeType.other);
          print("Saving file at: $filePath");
          if (filePath != null) {
            Conversion newConversion = Conversion(
              filePath: filePath,
              conversionType: 'pdf to xml',
              timestamp: DateTime.now().toIso8601String(),
            );

            // Add to conversion history
            await addConversion(newConversion);

            Get.snackbar('Success', 'xml saved successfully');
          }
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> convertPdfToWord(String pdfBytes, String outputFormat) async {
    try {
      isLoading.value = true;

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/generated.docx'; // Full path
      print("pdfFilePath: $filePath");
      final response =
          await _apiProvider.processPdfToWord(pdfBytes, outputFormat);

      if (response.statusCode == 200) {
        print("Word document generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'generated',
            bytes: Uint8List.fromList(response.data),
            ext: "docx",
            mimeType: MimeType.other,
          );
          if (filePath != null) {
            print("File saved at: $filePath");
            // completedConversions.add(Conversion(
            //   filePath: filePath,
            //   conversionType: 'pdf to word',
            //   timestamp: DateTime.now().toIso8601String(),
            // ));
            Conversion newConversion = Conversion(
              filePath: filePath,
              conversionType: 'pdf to word',
              timestamp: DateTime.now().toIso8601String(),
            );

            // Add to conversion history
            await addConversion(newConversion);
            Get.snackbar('Success', 'PDF saved successfully');
          }
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> covertPdfToRtText(
      String pdfBytes, String outputFormat) async {
    try {
      isLoading.value = true;
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
            name: 'text',
            bytes: Uint8List.fromList(response.data),
            ext: 'rtf',
            mimeType: MimeType.other,
          );

          // Conversion newConversion = Conversion(
          //   filePath: filePath!,
          //   conversionType: 'pdf to rttext',
          //   timestamp: DateTime.now().toIso8601String(),
          // );

          // // Add to conversion history
          // await addConversion(newConversion);

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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> covertPdfToPresentation(
      String pdfBytes, String outputFormat) async {
    try {
      isLoading.value = true;
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

          String? filePath = await FileSaver.instance.saveAs(
            name: 'presentation',
            bytes: Uint8List.fromList(response.data),
            ext: 'pptx',
            mimeType: MimeType.other,
          );

          if (filePath != null) {
            Conversion newConversion = Conversion(
              filePath: filePath,
              conversionType: 'pdf to presentation',
              timestamp: DateTime.now().toIso8601String(),
            );
            // Add to conversion history
            await addConversion(newConversion);
          }

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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> covertPdfToPdfa(String pdfBytes, String outputFormat) async {
    try {
      isLoading.value = true;
      print("pdfFilePath: $pdfBytes");
      final response = await _apiProvider.pdfToPdfA(pdfBytes, outputFormat);

      if (response.statusCode == 200) {
        print("Presentation generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdfa',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'pdf to pdfa',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> covertToImage(String pdfBytes, String imageFormat,
      String singleOrMultiple, String colorType, String dpi) async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.convertToImage(
          pdfBytes, imageFormat, singleOrMultiple, colorType, dpi);

      if (response.statusCode == 200) {
        print("Image generated successfully");

        // if (response.data is List<int>) {
        //   print(
        //       'Received valid binary data with length: ${response.data.length}');

        String? filePath = await FileSaver.instance.saveAs(
          name: 'genrated_img',
          bytes: Uint8List.fromList(response.data),
          ext: 'png',
          mimeType: MimeType.png,
        );

        Conversion newConversion = Conversion(
          filePath: filePath!,
          conversionType: 'pdf to image',
          timestamp: DateTime.now().toIso8601String(),
        );

        // Add to conversion history
        await addConversion(newConversion);

        Get.snackbar('Success', 'document saved successfully');
        //  else {
        //   print("Response data is not in expected binary format");
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error converting PDF to Word: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> covertPdfToCsv(String pdfBytes, int pageId) async {
    try {
      isLoading.value = true;
      print("pdfFilePath: $pdfBytes");
      final response = await _apiProvider.pdfToCsv(pdfBytes, pageId);

      if (response.statusCode == 200) {
        print("Csv file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_csv',
            bytes: Uint8List.fromList(response.data),
            ext: 'csv',
            mimeType: MimeType.text,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'pdf to csv',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> covertHtmlToPdf(String htmlBytes) async {
    try {
      isLoading.value = true;
      print("pdfFilePath: $htmlBytes");
      final response = await _apiProvider.htmlToPdf(htmlBytes);

      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'html to pdf',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> covertFileToPdf(String fileBytes) async {
    try {
      isLoading.value = true;
      print("pdfFilePath: $fileBytes");
      final response = await _apiProvider.processFileToPDF(fileBytes);

      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'file to pdf',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> convertPdftoHtml(String pdfBytes) async {
    try {
      isLoading.value = true;
      print("pdfFilePath: $pdfBytes");
      final response = await _apiProvider.processPdfToHTML(pdfBytes);

      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_html',
            bytes: Uint8List.fromList(response.data),
            ext: 'zip',
            mimeType: MimeType.zip,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'pdf to html',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> convertToPdf(List<String> imageBytes, String fitOption,
      String colorType, bool autoRotate) async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.convertToPdf(
          imageBytes, fitOption, colorType, autoRotate);

      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'images to pdf',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> sanitizePDF(
      String pdfBytes,
      bool removeJavaScript,
      bool removeEmbeddedFiles,
      bool removeMetadata,
      bool removeLinks,
      bool removeFonts) async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.sanitizePDF(
          pdfBytes,
          removeJavaScript,
          removeEmbeddedFiles,
          removeMetadata,
          removeLinks,
          removeFonts);
      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'sanitize pdf',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

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
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> removePassword(String pdfBytes, String password) async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.removePassword(pdfBytes, password);

      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'remove password',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

          Get.snackbar('Success', 'document unlock successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error unlock document: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> removeCertSignPDF(String pdfBytes) async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.removeCertSignPDF(pdfBytes);

      if (response.statusCode == 200) {
        print("pdf file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'remove certificate',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

          Get.snackbar('Success', 'Certificate remove successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error unlock document: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> getPdfInfo(String pdfBytes) async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.getPdfInfo(pdfBytes);

      if (response.statusCode == 200) {
        print("file generated successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'json',
            mimeType: MimeType.json,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'pdf info',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

          Get.snackbar('Success', 'file genrated successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error unlock document: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> addPassword(
      String pdfBytes,
      String ownerPassword,
      String password,
      int keyLength,
      bool canAssembleDocument,
      bool canExtractContent,
      bool canExtractForAccessibility,
      bool canFillInForm,
      bool canModify,
      bool canModifyAnnotations,
      bool canPrint,
      bool canPrintFaithful) async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.addPassword(
          pdfBytes,
          ownerPassword,
          password,
          keyLength,
          canAssembleDocument,
          canExtractContent,
          canExtractForAccessibility,
          canFillInForm,
          canModify,
          canModifyAnnotations,
          canPrint,
          canPrintFaithful);

      if (response.statusCode == 200) {
        print("password added successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');
          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );
          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'protect pdf',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);

          Get.snackbar('Success', 'password added successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error unlock document: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> repairPdf(
    String pdfBytes,
  ) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.repairPdf(
        pdfBytes,
      );

      if (response.statusCode == 200) {
        print("pdf repain successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          if (filePath != null) {
            Conversion newConversion = Conversion(
              filePath: filePath,
              conversionType: 'repair pdf',
              timestamp: DateTime.now().toIso8601String(),
            );

            // Add to conversion history
            await addConversion(newConversion);
          }

          Get.snackbar('Success', 'pdf repair successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error unlock document: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> addWatermark(
      String pdfBytes,
      String watermarkType,
      String watermarkText,
      String watermarkImage,
      String alphabet,
      double fontSize,
      double rotation,
      double opacity,
      int widthSpacer,
      int heightSpacer,
      bool convertPDFToImage) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.addWatermark(
          pdfBytes,
          watermarkType,
          watermarkText,
          watermarkImage,
          alphabet,
          fontSize,
          rotation,
          opacity,
          widthSpacer,
          heightSpacer,
          convertPDFToImage);

      if (response.statusCode == 200) {
        print("Watermark added successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          if (filePath != null) {
            Conversion newConversion = Conversion(
              filePath: filePath,
              conversionType: 'add watermark',
              timestamp: DateTime.now().toIso8601String(),
            );

            // Add to conversion history
            await addConversion(newConversion);
          }

          Get.snackbar('Success', 'pdf repair successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error unlock document: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> removeBlankPages(
      String pdfBytes, int threshold, double whitePercent) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.removeBlankPages(
          pdfBytes, threshold, whitePercent);

      if (response.statusCode == 200) {
        print("PDF repaired successfully");
        print("Response data type: ${response.data.runtimeType}");
        print("Response data content length: ${response.data.length}");

        // Assuming the API returns binary data
        if (response.data is List<int>) {
          // If the response data is a List<int> (binary data)
          final byteData = Uint8List.fromList(response.data);

          String? filePath = await FileSaver.instance.saveAs(
            name: 'generated_pdf',
            bytes: byteData,
            ext: 'zip',
            mimeType: MimeType.zip,
          );

          if (filePath != null) {
            Conversion newConversion = Conversion(
              filePath: filePath,
              conversionType: 'remove blank pages',
              timestamp: DateTime.now().toIso8601String(),
            );

            // Add to conversion history
            await addConversion(newConversion);
          }

          Get.snackbar('Success', 'Removed blank pages successfully');
        } else if (response.data is String && response.data.startsWith('PK')) {
          // If it's a string representation of binary data
          List<int> bytes = utf8.encode(response.data);
          final byteData = Uint8List.fromList(bytes);

          String? filePath = await FileSaver.instance.saveAs(
            name: 'generated_pdf',
            bytes: byteData,
            ext: 'zip',
            mimeType: MimeType.zip,
          );

          if (filePath != null) {
            Conversion newConversion = Conversion(
              filePath: filePath,
              conversionType: 'remove blank pages',
              timestamp: DateTime.now().toIso8601String(),
            );

            // Add to conversion history
            await addConversion(newConversion);
          }

          Get.snackbar('Success', 'Removed blank pages successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error unlock document: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> flattenPdf(String pdfBytes, bool flattenOnlyForms) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.flatten(pdfBytes, flattenOnlyForms);

      if (response.statusCode == 200) {
        print("pdf flatten successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          String? filePath = await FileSaver.instance.saveAs(
            name: 'genrated_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          if (filePath != null) {
            Conversion newConversion = Conversion(
              filePath: filePath,
              conversionType: 'flatten pdf',
              timestamp: DateTime.now().toIso8601String(),
            );

            // Add to conversion history
            await addConversion(newConversion);
          }

          Get.snackbar('Success', 'pdf flatten successfully');
        } else {
          print("Response data is not in expected binary format");
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print('Error unlock document: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> extractImage(String pdfBytes, String format) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.extractImages(pdfBytes, format);

      if (response.statusCode == 200) {
        print("pdf flatten successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          String? filePath = await FileSaver.instance.saveAs(
            name: 'generated_images',
            bytes: Uint8List.fromList(response.data),
            ext: 'zip',
            mimeType: MimeType.zip,
          );

          if (filePath != null) {
            Conversion newConversion = Conversion(
              filePath: filePath,
              conversionType: 'extract images',
              timestamp: DateTime.now().toIso8601String(),
            );

            // Add to conversion history
            await addConversion(newConversion);
          }

          // Confirm success
          Get.snackbar('Success', 'images saved successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> compressPdf(
      String pdfBytes, int optimizeLevel, String expectedOutputSize) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.optimizePdf(
          pdfBytes, optimizeLevel, expectedOutputSize);

      if (response.statusCode == 200) {
        print("pdf compressed successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          String? filePath = await FileSaver.instance.saveAs(
            name: 'compressed',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          if (filePath != null) {
            Conversion newConversion = Conversion(
              filePath: filePath,
              conversionType: 'compress',
              timestamp: DateTime.now().toIso8601String(),
            );

            // Add to conversion history
            await addConversion(newConversion);
          }

          // Confirm success
          Get.snackbar('Success', 'pdf compressed successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> autoSplitPdf(String pdfBytes, bool duplexMode) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.autoSplitPdf(pdfBytes, duplexMode);

      if (response.statusCode == 200) {
        print("pdf split successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          await FileSaver.instance.saveAs(
            name: 'split',
            bytes: Uint8List.fromList(response.data),
            ext: 'zip',
            mimeType: MimeType.zip,
          );

          // if (filePath != null) {
          //   Conversion newConversion = Conversion(
          //     filePath: filePath,
          //     conversionType: 'split by size',
          //     timestamp: DateTime.now().toIso8601String(),
          //   );

          //   // Add to conversion history
          //   await addConversion(newConversion);
          // } else if (filePath != null) {
          //   Conversion newConversion = Conversion(
          //     filePath: filePath,
          //     conversionType: 'split by doc count',
          //     timestamp: DateTime.now().toIso8601String(),
          //   );

          //   // Add to conversion history
          //   await addConversion(newConversion);
          // } else {
          //   Conversion newConversion = Conversion(
          //     filePath: filePath!,
          //     conversionType: 'split by page count',
          //     timestamp: DateTime.now().toIso8601String(),
          //   );

          //   // Add to conversion history
          //   await addConversion(newConversion);
          // }

          // Confirm success
          Get.snackbar('Success', 'pdf split successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> autoRename(String pdfBytes) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.extractHeader(pdfBytes);

      if (response.statusCode == 200) {
        print("auto renamed successfully");

        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // await FileSaver.instance.saveas(
          //   name: 'rename',
          //   bytes: Uint8List.fromList(response.data),
          //   ext: 'pdf',
          //   mimeType: MimeType.pdf,
          // );
          // Automatically save the file without asking
          Directory directory = await getApplicationDocumentsDirectory();
          // Dynamic filename with timestamp
          String newFileName =
              'rename_${DateTime.now().millisecondsSinceEpoch}.pdf';
          String newFilePath = '${directory.path}/$newFileName';
          // Write the binary data to the file
          File file = File(newFilePath);
          await file.writeAsBytes(Uint8List.fromList(response.data));

          Conversion newConversion = Conversion(
            filePath: newFilePath,
            conversionType: 'auto rename',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);
          // Confirm success
          print('New file saved: $newFileName');
          Get.snackbar(
              'Success', 'PDF renamed to $newFileName and saved successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> addStamp(
      String pdfBytes,
      String pageNumbers,
      String stampType,
      String stampText,
      String stampImage,
      String alphabet,
      double fontSize,
      double rotation,
      double opacity,
      int position,
      double overrideX,
      double overrideY,
      String customMargin,
      String customColor) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.addStamp(
          pdfBytes,
          pageNumbers,
          stampType,
          stampText,
          stampImage,
          alphabet,
          fontSize,
          rotation,
          opacity,
          position,
          overrideX,
          overrideY,
          customMargin,
          customColor);

      if (response.statusCode == 200) {
        print("stamp added successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          await FileSaver.instance.saveAs(
            name: 'stamp',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          // Conversion newConversion = Conversion(
          //   filePath: filePath!,
          //   conversionType: 'add stamp',
          //   timestamp: DateTime.now().toIso8601String(),
          // );

          // // Add to conversion history
          // await addConversion(newConversion);

          // Confirm success
          Get.snackbar('Success', 'stamp added successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> addPageNumber(
      String pdfBytes,
      String pageNumbers,
      String customMargin,
      int position,
      int startingNumber,
      String pagesToNumber,
      String customText) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.addPageNumbers(pdfBytes, pageNumbers,
          customMargin, position, startingNumber, pagesToNumber, customText);

      if (response.statusCode == 200) {
        print("PageNum added successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          String? filePath = await FileSaver.instance.saveAs(
            name: 'pages',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'add page num',
            timestamp: DateTime.now().toIso8601String(),
          );

          // Add to conversion history
          await addConversion(newConversion);
          // Confirm success
          Get.snackbar('Success', 'page number added successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> autoSplitPdf_1(
      String pdfBytes, int splitType, String splitValue) async {
    try {
      isLoading.value = true;

      final response =
          await _apiProvider.autoSplitPdf_1(pdfBytes, splitType, splitValue);

      if (response.statusCode == 200) {
        print("PageNum added successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          await FileSaver.instance.saveAs(
            name: 'split',
            bytes: Uint8List.fromList(response.data),
            ext: 'zip',
            mimeType: MimeType.zip,
          );

          // if (filePath != null) {
          //   Conversion newConversion = Conversion(
          //     filePath: filePath,
          //     conversionType: 'split by size',
          //     timestamp: DateTime.now().toIso8601String(),
          //   );

          //   // Add to conversion history
          //   await addConversion(newConversion);
          // } else if (filePath != null) {
          //   Conversion newConversion = Conversion(
          //     filePath: filePath,
          //     conversionType: 'split by doc count',
          //     timestamp: DateTime.now().toIso8601String(),
          //   );

          //   // Add to conversion history
          //   await addConversion(newConversion);
          // } else {
          //   Conversion newConversion = Conversion(
          //     filePath: filePath!,
          //     conversionType: 'split by page count',
          //     timestamp: DateTime.now().toIso8601String(),
          //   );

          //   // Add to conversion history
          //   await addConversion(newConversion);
          // }

          // Confirm success
          Get.snackbar('Success', 'Auto split successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> rotatePdf(String pdfBytes, int angle) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.rotatePDF(pdfBytes, angle);

      if (response.statusCode == 200) {
        print("PageNum added successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          String? filePath = await FileSaver.instance.saveAs(
            name: 'rotate',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'add page num',
            timestamp: DateTime.now().toIso8601String(),
          );
          // Add to conversion history
          await addConversion(newConversion);
          // Confirm success
          Get.snackbar('Success', 'Pdf rotated successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> deletePages(String pdfBytes, String pageNumbers) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.deletePages(pdfBytes, pageNumbers);

      if (response.statusCode == 200) {
        print("PageNum added successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          String? filePath = await FileSaver.instance.saveAs(
            name: 'remove',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'delete pages',
            timestamp: DateTime.now().toIso8601String(),
          );
          // Add to conversion history
          await addConversion(newConversion);

          // Confirm success
          Get.snackbar('Success', 'Pages removed successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> removeImages(String pdfBytes) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.removeImages(pdfBytes);

      if (response.statusCode == 200) {
        print("PageNum added successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          String? filePath = await FileSaver.instance.saveAs(
            name: 'remove',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'remove images',
            timestamp: DateTime.now().toIso8601String(),
          );
          // Add to conversion history
          await addConversion(newConversion);

          // Confirm success
          Get.snackbar('Success', 'Images removed successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> pdfToSinglePage(String pdfBytes) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.pdfToSinglePage(pdfBytes);

      if (response.statusCode == 200) {
        print("PageNum added successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          String? filePath = await FileSaver.instance.saveAs(
            name: 'singlepage',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'pdf to single page',
            timestamp: DateTime.now().toIso8601String(),
          );
          // Add to conversion history
          await addConversion(newConversion);
          // Confirm success
          Get.snackbar('Success', 'pdf to single page converted successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> overlayPdfs(String pdfBytes, List<String> overlayFiles,
      String overlayMode, List<int> counts, int overlayPosition) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.overlayPdfs(
          pdfBytes, overlayFiles, overlayMode, counts, overlayPosition);

      if (response.statusCode == 200) {
        print("PageNum added successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          String? filePath = await FileSaver.instance.saveAs(
            name: 'overlay',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'pdf to single page',
            timestamp: DateTime.now().toIso8601String(),
          );
          // Add to conversion history
          await addConversion(newConversion);

          // Confirm success
          Get.snackbar('Success', 'pdf overlay successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> mergeMultiplePagesIntoOne(
      String pdfBytes, int pagesPerSheet, bool addBorder) async {
    try {
      isLoading.value = true;

      final response = await _apiProvider.mergeMultiplePagesIntoOne(
          pdfBytes, pagesPerSheet, addBorder);
      if (response.statusCode == 200) {
        print("PageNum added successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          String? filePath = await FileSaver.instance.saveAs(
            name: 'singlepage',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'mul page into one',
            timestamp: DateTime.now().toIso8601String(),
          );
          // Add to conversion history
          await addConversion(newConversion);
          // Confirm success
          Get.snackbar('Success', 'multiple pages into one successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> cropPdf(
      String pdfBytes, double x, double y, double width, double height) async {
    try {
      isLoading.value = true;

      final response =
          await _apiProvider.cropPdf(pdfBytes, x, y, width, height);
      if (response.statusCode == 200) {
        print("PageNum added successfully");

        // Ensure data is of type List<int> (binary data)
        if (response.data is List<int>) {
          print(
              'Received valid binary data with length: ${response.data.length}');

          // Properly save the data to a zip file
          String? filePath = await FileSaver.instance.saveAs(
            name: 'cropped_pdf',
            bytes: Uint8List.fromList(response.data),
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );

          Conversion newConversion = Conversion(
            filePath: filePath!,
            conversionType: 'crop pdf',
            timestamp: DateTime.now().toIso8601String(),
          );
          // Add to conversion history
          await addConversion(newConversion);
          // Confirm success
          Get.snackbar('Success', 'pdf cropped successfully');
        } else {
          print("Response data is not in expected binary format");
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        print("Something went wrong: ${response.statusMessage}");
        Get.snackbar('Error', 'Something went wrong with the API');
      }
    } catch (e) {
      print('Error unlocking document: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
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

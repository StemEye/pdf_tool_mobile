import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

class PickedfileScreen extends StatelessWidget {
  const PickedfileScreen(
      //List<String> list,
      {super.key,
      this.filePath,
      required this.conversionType,
      this.imagePaths});
  final String? filePath;
  final String conversionType;
  final List<String>? imagePaths;

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("Picked File"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              //'Picked File:${filePath?.split('/').last}',
              'Picked File: ${filePath?.split('/').last ?? 'Multiple Images'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await homeController.requestStoragePermission();
                //await homeController.requestGalleryPermission();
                if (conversionType == 'pdf to xml') {
                  homeController.convertPdfToXml(filePath!);
                } else if (conversionType == 'pdf to word') {
                  homeController.convertPdfToWord(filePath!, 'docx');
                } else if (conversionType == 'pdf to rttext') {
                  homeController.covertPdfToRtText(filePath!, 'rtf');
                } else if (conversionType == 'pdf to presentation') {
                  homeController.covertPdfToPresentation(filePath!, 'pptx');
                } else if (conversionType == 'pdf to pdfa') {
                  homeController.covertPdfToPdfa(filePath!, 'pdf');
                } else if (conversionType == 'pdf to image') {
                  homeController.covertToImage(
                      filePath!, 'png', 'single', 'color', '300');
                } else if (conversionType == 'pdf to csv') {
                  int pageId = 1;
                  homeController.covertPdfToCsv(filePath!, pageId);
                } else if (conversionType == 'html to pdf') {
                  homeController.covertHtmlToPdf(filePath!);
                } else if (conversionType == 'file to pdf') {
                  homeController.covertFileToPdf(filePath!);
                } else if (conversionType == 'pdf to html') {
                  homeController.convertPdftoHtml(filePath!);
                } else if (conversionType == 'images to pdf' &&
                    imagePaths != null) {
                  homeController.convertToPdf(
                      imagePaths!, 'fit', 'color', true);
                } else if (conversionType == 'sanitize pdf') {
                  bool removeJavaScript = true;
                  bool removeEmbeddedFiles = true;
                  bool removeMetadata = true;
                  bool removeLinks = true;
                  bool removeFonts = false;
                  homeController.sanitizePDF(
                      filePath!,
                      removeJavaScript,
                      removeEmbeddedFiles,
                      removeMetadata,
                      removeLinks,
                      removeFonts);
                } else if (conversionType == 'remove certificate') {
                  homeController.removeCertSignPDF(filePath!);
                } else if (conversionType == 'pdf info') {
                  homeController.getPdfInfo(filePath!);
                } else if (conversionType == 'repair pdf') {
                  homeController.repairPdf(filePath!);
                } else if (conversionType == 'flatten pdf') {
                  bool flattenOnlyForms = false;

                  homeController.flattenPdf(filePath!, flattenOnlyForms);
                } else if (conversionType == 'extract images') {
                  String imageformat = 'png';
                  homeController.extractImage(filePath!, imageformat);
                }
              },
              child: Text('convert $conversionType'),
            ),
          ],
        ),
      ),
    );
  }
}

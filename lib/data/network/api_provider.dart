import 'package:dio/dio.dart';
import 'api_interceptor.dart';

/// Created by Babar on 2/25/2022.
abstract class ApiProvider {
  Future<Response> markdownToPdf(String markdown);
  Future<Response> urlToPdf(String url);
  Future<Response> processPdfToXML(String pdfBytes);
  Future<Response> processPdfToWord(String pdfBytes, String outputFormat);
  Future<Response> processPdfToRTForTXT(String pdfBytes, String outputFormat);
  Future<Response> processPdfToPresentation(
      String pdfBytes, String outputFormat);
  Future<Response> pdfToPdfA(String pdfBytes, String outputFormat);
  Future<Response> convertToImage(String pdfBytes, String imageFormat,
      String singleOrMultiple, String colorType, String dpi);
  Future<Response> pdfToCsv(String pdfBytes, int pageId);
  Future<Response> htmlToPdf(String htmlBytes);
  Future<Response> convertToPdf(List<String> imageBytes, String fitOption,
      String colorType, bool autoRotate);
  Future<Response> processFileToPDF(String fileBytes);
  Future<Response> processPdfToHTML(String pdfBytes);

  Future<Response> sanitizePDF(
      String pdfBytes,
      bool removeJavaScript,
      bool removeEmbeddedFiles,
      bool removeMetadata,
      bool removeLinks,
      bool removeFonts);
  Future<Response> removePassword(String pdfBytes, String password);
  Future<Response> removeCertSignPDF(String pdfBytes);
  Future<Response> getPdfInfo(String pdfBytes);
  Future<Response> signPDFWithCert(
      String pdfBytes,
      String certType,
      String privateKeyFile,
      String certFile,
      String p12File,
      String jksFile,
      String password,
      bool showSignature,
      String reason,
      String location,
      String name,
      int pageNumber);
  Future<Response> redactPdf(
      String pdfBytes,
      String listOfText,
      bool useRegex,
      bool wholeWordSearch,
      String redactColor,
      double customPadding,
      bool convertPDFToImage);
  Future<Response> addWatermark(
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
      bool convertPDFToImage);
  Future<Response> addPassword(
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
      bool canPrintFaithful);
  Future<Response> handleData(List<String> fileInput, String json);
  Future<Response> metadata(
      String pdfBytes,
      bool deleteAll,
      String author,
      String creationDate,
      String creator,
      String keywords,
      String modificationDate,
      String producer,
      String subject,
      String title,
      String trapped,
      Map<String, String> allRequestParams);
  Future<Response> extractHeader(String pdfBytes);
  Future<Response> repairPdf(String pdfBytes);
  Future<Response> removeBlankPages(
      String pdfBytes, int threshold, double whitePercent);
  Future<Response> processPdfWithOCR(
      String pdfBytes,
      List<String> languages,
      bool sidecar,
      bool deskew,
      bool clean,
      bool cleanFinal,
      String ocrType,
      String ocrRenderType,
      bool removeImagesAfter);
  Future<Response> flatten(String pdfBytes, bool flattenOnlyForms);
  Future<Response> extractImages(String pdfBytes, String format);
  Future<Response> extractImageScans(String pdfBytes, int angleThreshold,
      int tolerance, int minArea, int minContourArea, int borderSize);
  Future<Response> optimizePdf(
      String pdfBytes, int optimizeLevel, String expectedOutputSize);
  Future<Response> autoSplitPdf(String pdfBytes, bool duplexMode);
  Future<Response> extractHeader_1(
      String pdfBytes, bool useFirstTextAsFallback);
  Future<Response> addStamp(
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
      String customColor);
  Future<Response> addPageNumbers(
      String pdfBytes,
      String pageNumbers,
      String customMargin,
      int position,
      int startingNumber,
      String pagesToNumber,
      String customText);
  Future<Response> overlayImage(
      String pdfBytes, String imageFile, double x, double y, bool everyPage);
  Future<Response> splitPdf(String pdfBytes, int horizontalDivisions,
      int verticalDivisions, bool merge);
  Future<Response> splitPdf_1(String pdfBytes, String pageNumbers);
  Future<Response> autoSplitPdf_1(
      String pdfBytes, int splitType, String splitValue);
  Future<Response> scalePages(
      String pdfBytes, String pageSize, double scaleFactor);
  Future<Response> rotatePDF(String pdfBytes, int angle);
  Future<Response> deletePages(String pdfBytes, String pageNumbers);
  Future<Response> removeImages(String pdfBytes);
  Future<Response> rearrangePages(
      String pdfBytes, String pageNumbers, String customMode);
  Future<Response> pdfToSinglePage(String pdfBytes);
  Future<Response> overlayPdfs(String pdfBytes, List<String> overlayFiles,
      String overlayMode, List<int> counts, int overlayPosition);
  Future<Response> mergeMultiplePagesIntoOne(
      String pdfBytes, int pagesPerSheet, bool addBorder);
  Future<Response> mergePdfs(
      List<String> fileInput, String sortType, bool removeCertSign);
  Future<Response> cropPdf(
      String pdfBytes, double x, double y, double width, double height);
  Future<Response> pageSize(
      String pdfBytes, String comparator, String standardPageSize);
  Future<Response> pageRotation(
      String pdfBytes, String comparator, int rotation);
  Future<Response> pageCount(
      String pdfBytes, String comparator, String pageCount);
  Future<Response> fileSize(
      String pdfBytes, String comparator, String fileSize);
  Future<Response> containsText(
      String pdfBytes, String pageNumbers, String text);
  Future<Response> containsImage(String pdfBytes, String pageNumbers);
  Future<Response> getUptime();
  Future<Response> getStatus();
  Future<Response> getTotalRequests(String? endpoint);
  Future<Response> getAllPostRequests();
  Future<Response> getPageLoads(String? endpoint);
  Future<Response> getAllEndpointLoads();
}

class ApiProviderImpl implements ApiProvider {
  final Dio _dio = Dio(options);

  ApiProviderImpl(ApiInterceptor apiInterceptor) {
    _dio.interceptors.add(apiInterceptor);
  }

  static BaseOptions options = BaseOptions(
    baseUrl: "http://3.82.232.141/api/v1",

    contentType: Headers.multipartFormDataContentType,
    //"application/json",
    followRedirects: false,
    //responseType: ResponseTy,
    responseType: ResponseType.plain,
    connectTimeout: const Duration(seconds: 40),
    receiveTimeout: const Duration(seconds: 40),
    validateStatus: (status) {
      return status! < 500;
    },
  );

  @override
  Future<Response> markdownToPdf(String markdown) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        markdown,
        filename: "input.md",
      ),
    });
    //return _dio.post('/convert/markdown/pdf', data: formData);
    final response = await _dio.post('/convert/markdown/pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> urlToPdf(String url) async {
    // create form data
    final formData = FormData.fromMap({
      "urlInput": url,
    });
    //return _dio.post('/convert/url/pdf', data: formData);
    final response = await _dio.post('/convert/url/pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

  @override
  Future<Response> processPdfToXML(String pdfBytes) async {
    // create form data
    // final formData = FormData.fromMap({
    //   "fileInput": MultipartFile.fromString(
    //     pdfBytes,
    //     filename: "input.pdf",
    //   ),
    // });

    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(pdfBytes,
          //filename: "input.pdf",
          contentType: DioMediaType.parse('application/pdf')),
    });
    //return _dio.post('/convert/pdf/xml', data: formData);
    final response = await _dio.post('/convert/pdf/xml',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

  @override
  Future<Response> processPdfToWord(
      String pdfBytes, String outputFormat) async {
    // create form data
    //   final formData = FormData.fromMap({
    //     "fileInput": await MultipartFile.fromString(
    //       pdfBytes,
    //       //filename: "input.pdf",
    //       contentType: DioMediaType.parse('application/pdf'),
    //     ),
    //     "outputFormat": outputFormat,
    //   });
    //   return _dio.post('/convert/pdf/word', data: formData);
    // }

    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(pdfBytes,
          //filename: "input.pdf",
          contentType: DioMediaType.parse('application/pdf')),
      "outputFormat": outputFormat,
    });
    print('Sending request to /convert/pdf/word with form data: $formData');

    // return _dio.post('/convert/pdf/word', data: formData);

    final response = await _dio.post('/convert/pdf/word',
        data: formData, options: Options(responseType: ResponseType.bytes));

    // print('Response status: ${response.statusCode}');
    // print('Response data type: ${response.data.runtimeType}');
    // print(
    //     'Response data length: ${response.data.length ?? 'No length (may be string)'}');

    return response;
  }

  @override
  Future<Response> processPdfToRTForTXT(
      String pdfBytes, String outputFormat) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "outputFormat": outputFormat,
    });
    print('Sending request to /convert/pdf/text with form data: $formData');

    //return _dio.post('/convert/pdf/text', data: formData);
    final response = await _dio.post('/convert/pdf/text',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> processPdfToPresentation(
      String pdfBytes, String outputFormat) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "outputFormat": outputFormat,
    });
    //return _dio.post('/convert/pdf/presentation', data: formData);
    final response = await _dio.post('/convert/pdf/presentation',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> pdfToPdfA(String pdfBytes, String outputFormat) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "outputFormat": outputFormat,
    });
    //return _dio.post('/convert/pdf/pdfa', data: formData);
    final response = await _dio.post('/convert/pdf/pdfa',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> convertToImage(String pdfBytes, String imageFormat,
      String singleOrMultiple, String colorType, String dpi) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        filename: "input.pdf",
      ),
      "imageFormat": imageFormat,
      "singleOrMultiple": singleOrMultiple,
      "colorType": colorType,
      "dpi": dpi,
    });
    //return _dio.post('/convert/pdf/img', data: formData);
    final response = await _dio.post('/convert/pdf/img',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> pdfToCsv(String pdfBytes, int pageId) async {
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "pageId": pageId,
    });
    //return _dio.post('/convert/pdf/csv', data: formData);
    final response = await _dio.post('/convert/pdf/csv',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> htmlToPdf(String htmlBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        htmlBytes,
        filename: "input.html",
      ),
    });
    //return _dio.post('/convert/html/pdf', data: formData);
    final response = await _dio.post('/convert/html/pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> convertToPdf(List<String> imageBytes, String fitOption,
      String colorType, bool autoRotate) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": imageBytes
          .map((byte) => MultipartFile.fromString(
                byte,
                filename: "input.jpg",
              ))
          .toList(),
      "fitOption": fitOption,
      "colorType": colorType,
      "autoRotate": autoRotate,
    });
    //return _dio.post('/convert/img/pdf', data: formData);
    final response = await _dio.post('/convert/img/pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> processFileToPDF(String fileBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        fileBytes,
        //filename: "input.file", // Adjust filename based on actual file type
        contentType: DioMediaType.parse('application/pdf'),
      ),
    });
    //return _dio.post('/convert/file/pdf', data: formData);
    final response = await _dio.post('/convert/file/pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> processPdfToHTML(String pdfBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
    });
    //return _dio.post('/convert/pdf/html', data: formData);
    final response = await _dio.post('/convert/pdf/html',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> sanitizePDF(
      String pdfBytes,
      bool removeJavaScript,
      bool removeEmbeddedFiles,
      bool removeMetadata,
      bool removeLinks,
      bool removeFonts) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "removeJavaScript": removeJavaScript,
      "removeEmbeddedFiles": removeEmbeddedFiles,
      "removeMetadata": removeMetadata,
      "removeLinks": removeLinks,
      "removeFonts": removeFonts,
    });
    //return _dio.post('/security/sanitize-pdf', data: formData);
    final response = await _dio.post('/security/sanitize-pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> removePassword(String pdfBytes, String password) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "password": password,
    });
    //return _dio.post('/security/remove-password', data: formData);
    final response = await _dio.post('/security/remove-password',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> removeCertSignPDF(String pdfBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
    });
    //return _dio.post('/security/remove-cert-sign', data: formData);
    final response = await _dio.post('/security/remove-password',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> getPdfInfo(String pdfBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
    });
    //return _dio.post('/security/get-info-on-pdf', data: formData);
    final response = await _dio.post('/security/get-info-on-pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> signPDFWithCert(
      String pdfBytes,
      String certType,
      String privateKeyFile,
      String certFile,
      String p12File,
      String jksFile,
      String password,
      bool showSignature,
      String reason,
      String location,
      String name,
      int pageNumber) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "certType": certType,
      "privateKeyFile": MultipartFile.fromString(
        privateKeyFile,
        filename:
            "private_key.pem", // Adjust filename based on actual file type
      ),
      "certFile": MultipartFile.fromString(
        certFile,
        filename: "cert.pem", // Adjust filename based on actual file type
      ),
      "p12File": MultipartFile.fromString(
        p12File,
        filename: "p12.p12", // Adjust filename based on actual file type
      ),
      "jksFile": MultipartFile.fromString(
        jksFile,
        filename: "jks.jks", // Adjust filename based on actual file type
      ),
      "password": password,
      "showSignature": showSignature,
      "reason": reason,
      "location": location,
      "name": name,
      "pageNumber": pageNumber,
    });
    return _dio.post('/security/cert-sign', data: formData);
  }

  @override
  Future<Response> redactPdf(
      String pdfBytes,
      String listOfText,
      bool useRegex,
      bool wholeWordSearch,
      String redactColor,
      double customPadding,
      bool convertPDFToImage) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "listOfText": listOfText,
      "useRegex": useRegex,
      "wholeWordSearch": wholeWordSearch,
      "redactColor": redactColor,
      "customPadding": customPadding,
      "convertPDFToImage": convertPDFToImage,
    });
    return _dio.post('/security/auto-redact', data: formData);
  }

// issue
  @override
  Future<Response> addWatermark(
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
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "watermarkType": watermarkType,
      "watermarkText": watermarkText,
      "watermarkImage": MultipartFile.fromString(
        watermarkImage,
        filename: "watermark.png", // Adjust filename based on actual file type
      ),
      "alphabet": alphabet,
      "fontSize": fontSize,
      "rotation": rotation,
      "opacity": opacity,
      "widthSpacer": widthSpacer,
      "heightSpacer": heightSpacer,
      "convertPDFToImage": convertPDFToImage,
    });
    //return _dio.post('/security/add-watermark', data: formData);
    final response = await _dio.post('/security/add-watermark',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> addPassword(
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
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "ownerPassword": ownerPassword,
      "password": password,
      "keyLength": keyLength,
      "canAssembleDocument": canAssembleDocument,
      "canExtractContent": canExtractContent,
      "canExtractForAccessibility": canExtractForAccessibility,
      "canFillInForm": canFillInForm,
      "canModify": canModify,
      "canModifyAnnotations": canModifyAnnotations,
      "canPrint": canPrint,
      "canPrintFaithful": canPrintFaithful,
    });
    //return _dio.post('/security/add-password', data: formData);

    final response = await _dio.post('/security/add-password',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

//cannot working
  @override
  Future<Response> handleData(List<String> fileInput, String json) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": fileInput
          .map((byte) => MultipartFile.fromFile(
                byte,
                filename:
                    "input.file", // Adjust filename based on actual file type
              ))
          .toList(),
      "json": json,
    });
    return _dio.post('/pipeline/handleData', data: formData);
  }

//cannot working
  @override
  Future<Response> metadata(
      String pdfBytes,
      bool deleteAll,
      String author,
      String creationDate,
      String creator,
      String keywords,
      String modificationDate,
      String producer,
      String subject,
      String title,
      String trapped,
      Map<String, String> allRequestParams) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "deleteAll": deleteAll,
      "author": author,
      "creationDate": creationDate,
      "creator": creator,
      "keywords": keywords,
      "modificationDate": modificationDate,
      "producer": producer,
      "subject": subject,
      "title": title,
      "trapped": trapped,
      "allRequestParams": allRequestParams,
    });
    return _dio.post('/misc/update-metadata', data: formData);
  }

//not accurate working working
  @override
  Future<Response> extractHeader(String pdfBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
    });
    //return _dio.post('/misc/show-javascript', data: formData);
    final response = await _dio.post('/misc/show-javascript',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> repairPdf(String pdfBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
    });
    return _dio.post('/misc/repair', data: formData);
    // final response = await _dio.post('/misc/repair',
    //     data: formData, options: Options(responseType: ResponseType.bytes));
    // return response;
  }

  @override
  Future<Response> removeBlankPages(
      String pdfBytes, int threshold, double whitePercent) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "threshold": threshold,
      "whitePercent": whitePercent,
    });
    //return _dio.post('/misc/remove-blanks', data: formData);
    final response = await _dio.post('/misc/remove-blanks',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

//not working
  @override
  Future<Response> processPdfWithOCR(
      String pdfBytes,
      List<String> languages,
      bool sidecar,
      bool deskew,
      bool clean,
      bool cleanFinal,
      String ocrType,
      String ocrRenderType,
      bool removeImagesAfter) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "languages": languages,
      "sidecar": sidecar,
      "deskew": deskew,
      "clean": clean,
      "cleanFinal": cleanFinal,
      "ocrType": ocrType,
      "ocrRenderType": ocrRenderType,
      "removeImagesAfter": removeImagesAfter,
    });
    return _dio.post('/misc/ocr-pdf', data: formData);
  }

  @override
  Future<Response> flatten(String pdfBytes, bool flattenOnlyForms) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "flattenOnlyForms": flattenOnlyForms,
    });
    //return _dio.post('/misc/flatten', data: formData);
    final response = await _dio.post('/misc/flatten',
        data: formData, options: Options(responseType: ResponseType.bytes));
    return response;
  }

  @override
  Future<Response> extractImages(String pdfBytes, String format) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "format": format,
    });
    //return _dio.post('/misc/extract-images', data: formData);
    final response = await _dio.post('/misc/extract-images',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

//not understanding
  @override
  Future<Response> extractImageScans(String pdfBytes, int angleThreshold,
      int tolerance, int minArea, int minContourArea, int borderSize) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "angleThreshold": angleThreshold,
      "tolerance": tolerance,
      "minArea": minArea,
      "minContourArea": minContourArea,
      "borderSize": borderSize,
    });
    return _dio.post('/misc/extract-image-scans', data: formData);
  }

  //only less then 1mb file compress, in app the compress file size increase
  @override
  Future<Response> optimizePdf(
      String pdfBytes, int optimizeLevel, String expectedOutputSize) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "optimizeLevel": optimizeLevel,
      "expectedOutputSize": expectedOutputSize,
    });
    //return _dio.post('/misc/compress-pdf', data: formData);
    final response = await _dio.post('/misc/compress-pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

  @override
  Future<Response> autoSplitPdf(String pdfBytes, bool duplexMode) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "duplexMode": duplexMode,
    });
    //return _dio.post('/misc/auto-split-pdf', data: formData);
    final response = await _dio.post('/misc/auto-split-pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

//similer to rename so, i use extractheader
  @override
  Future<Response> extractHeader_1(
      String pdfBytes, bool useFirstTextAsFallback) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "useFirstTextAsFallback": useFirstTextAsFallback,
    });
    //return _dio.post('/misc/auto-rename', data: formData);
    final response = await _dio.post('/misc/auto-rename',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

  @override
  Future<Response> addStamp(
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
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "pageNumbers": pageNumbers,
      "stampType": stampType,
      "stampText": stampText,
      "stampImage": MultipartFile.fromString(
        stampImage,
        filename: "stamp.png", // Adjust filename based on actual file type
      ),
      "alphabet": alphabet,
      "fontSize": fontSize,
      "rotation": rotation,
      "opacity": opacity,
      "position": position,
      "overrideX": overrideX,
      "overrideY": overrideY,
      "customMargin": customMargin,
      "customColor": customColor,
    });
    //return _dio.post('/misc/add-stamp', data: formData);
    final response = await _dio.post('/misc/add-stamp',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

  @override
  Future<Response> addPageNumbers(
      String pdfBytes,
      String pageNumbers,
      String customMargin,
      int position,
      int startingNumber,
      String pagesToNumber,
      String customText) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "pageNumbers": pageNumbers,
      "customMargin": customMargin,
      "position": position,
      "startingNumber": startingNumber,
      "pagesToNumber": pagesToNumber,
      "customText": customText,
    });
    //return _dio.post('/misc/add-page-numbers', data: formData);
    final response = await _dio.post('/misc/add-page-numbers',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

  //not working(file to large issue)
  @override
  Future<Response> overlayImage(String pdfBytes, String imageFile, double x,
      double y, bool everyPage) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "imageFile": MultipartFile.fromString(
        imageFile,
        filename: "overlay.png", // Adjust filename based on actual file type
      ),
      "x": x,
      "y": y,
      "everyPage": everyPage,
    });
    return _dio.post('/misc/add-image', data: formData);
  }

//similer to the autoSplitPdf_1
  @override
  Future<Response> splitPdf(String pdfBytes, int horizontalDivisions,
      int verticalDivisions, bool merge) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "horizontalDivisions": horizontalDivisions,
      "verticalDivisions": verticalDivisions,
      "merge": merge,
    });
    return _dio.post('/general/split-pdf-by-sections', data: formData);
  }

//similer to the autoSplitPdf_1
  @override
  Future<Response> splitPdf_1(String pdfBytes, String pageNumbers) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "pageNumbers": pageNumbers,
    });
    return _dio.post('/general/split-pages', data: formData);
  }

  @override
  Future<Response> autoSplitPdf_1(
      String pdfBytes, int splitType, String splitValue) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "splitType": splitType,
      "splitValue": splitValue,
    });
    //return _dio.post('/general/split-by-size-or-count', data: formData);
    final response = await _dio.post('/general/split-by-size-or-count',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

//test this more
  @override
  Future<Response> scalePages(
      String pdfBytes, String pageSize, double scaleFactor) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "pageSize": pageSize,
      "scaleFactor": scaleFactor,
    });
    return _dio.post('/general/scale-pages', data: formData);
  }

  @override
  Future<Response> rotatePDF(String pdfBytes, int angle) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "angle": angle,
    });
    //return _dio.post('/general/rotate-pdf', data: formData);
    final response = await _dio.post('/general/rotate-pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

  @override
  Future<Response> deletePages(String pdfBytes, String pageNumbers) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "pageNumbers": pageNumbers,
    });
    //return _dio.post('/general/remove-pages', data: formData);
    final response = await _dio.post('/general/remove-pages',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

  @override
  Future<Response> removeImages(String pdfBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
    });
    //return _dio.post('/general/remove-image-pdf', data: formData);
    final response = await _dio.post('/general/remove-image-pdf',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

//not useful
  @override
  Future<Response> rearrangePages(
      String pdfBytes, String pageNumbers, String customMode) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "pageNumbers": pageNumbers,
      "customMode": customMode,
    });
    return _dio.post('/general/rearrange-pages', data: formData);
  }

  @override
  Future<Response> pdfToSinglePage(String pdfBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
    });
    //return _dio.post('/general/pdf-to-single-page', data: formData);
    final response = await _dio.post('/general/pdf-to-single-page',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

//not working properly
  @override
  Future<Response> overlayPdfs(String pdfBytes, List<String> overlayFiles,
      String overlayMode, List<int> counts, int overlayPosition) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "overlayFiles": overlayFiles
          .map((byte) => MultipartFile.fromString(
                byte,
                filename:
                    "overlay.pdf", // Adjust filename based on actual file type
              ))
          .toList(),
      "overlayMode": overlayMode,
      "counts": counts,
      "overlayPosition": overlayPosition,
    });
    //return _dio.post('/general/overlay-pdfs', data: formData);
    final response = await _dio.post('/general/overlay-pdfs',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

  @override
  Future<Response> mergeMultiplePagesIntoOne(
      String pdfBytes, int pagesPerSheet, bool addBorder) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "pagesPerSheet": pagesPerSheet,
      "addBorder": addBorder,
    });
    //return _dio.post('/general/multi-page-layout', data: formData);
    final response = await _dio.post('/general/multi-page-layout',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

// issue in api
  @override
  Future<Response> mergePdfs(
      List<String> fileInput, String sortType, bool removeCertSign) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": fileInput
          .map((byte) => MultipartFile.fromString(
                byte,
                filename:
                    "input.pdf", // Adjust filename based on actual file type
              ))
          .toList(),
      "sortType": sortType,
      "removeCertSign": removeCertSign,
    });
    return _dio.post('/general/merge-pdfs', data: formData);
  }

  @override
  Future<Response> cropPdf(
      String pdfBytes, double x, double y, double width, double height) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": await MultipartFile.fromFile(
        pdfBytes,
        //filename: "input.pdf",
        contentType: DioMediaType.parse('application/pdf'),
      ),
      "x": x,
      "y": y,
      "width": width,
      "height": height,
    });
    //return _dio.post('/general/crop', data: formData);
    final response = await _dio.post('/general/crop',
        data: formData, options: Options(responseType: ResponseType.bytes));

    return response;
  }

// no result genrate
  @override
  Future<Response> pageSize(
      String pdfBytes, String comparator, String standardPageSize) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "comparator": comparator,
      "standardPageSize": standardPageSize,
    });
    return _dio.post('/filter/filter-page-size', data: formData);
  }

//already added this type of functionality
  @override
  Future<Response> pageRotation(
      String pdfBytes, String comparator, int rotation) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "comparator": comparator,
      "rotation": rotation,
    });
    return _dio.post('/filter/filter-page-rotation', data: formData);
  }

//cannot genrate result
  @override
  Future<Response> pageCount(
      String pdfBytes, String comparator, String pageCount) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "comparator": comparator,
      "pageCount": pageCount,
    });
    return _dio.post('/filter/filter-page-count', data: formData);
  }

// server error
  @override
  Future<Response> fileSize(
      String pdfBytes, String comparator, String fileSize) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "comparator": comparator,
      "fileSize": fileSize,
    });
    return _dio.post('/filter/filter-file-size', data: formData);
  }

// response code 200 but cannot genrate pdf
  @override
  Future<Response> containsText(
      String pdfBytes, String pageNumbers, String text) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "pageNumbers": pageNumbers,
      "text": text,
    });
    return _dio.post('/filter/filter-contains-text', data: formData);
  }

// response code 200 but cannot genrate pdf

  @override
  Future<Response> containsImage(String pdfBytes, String pageNumbers) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "pageNumbers": pageNumbers,
    });
    return _dio.post('/filter/filter-contains-image', data: formData);
  }

  @override
  Future<Response> getUptime() async {
    return _dio.get('/info/uptime');
  }

  @override
  Future<Response> getStatus() async {
    return _dio.get('/info/status');
  }

  @override
  Future<Response> getTotalRequests(String? endpoint) async {
    if (endpoint != null) {
      return _dio
          .get('/info/requests', queryParameters: {"endpoint": endpoint});
    } else {
      return _dio.get('/info/requests');
    }
  }

  @override
  Future<Response> getAllPostRequests() async {
    return _dio.get('/info/requests/all');
  }

  @override
  Future<Response> getPageLoads(String? endpoint) async {
    if (endpoint != null) {
      return _dio.get('/info/loads', queryParameters: {"endpoint": endpoint});
    } else {
      return _dio.get('/info/loads');
    }
  }

  @override
  Future<Response> getAllEndpointLoads() async {
    return _dio.get('/info/loads/all');
  }
}

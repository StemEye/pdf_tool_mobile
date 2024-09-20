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
  Future<Response> PdfToCsv(String pdfBytes, int pageId);
  Future<Response> HtmlToPdf(String htmlBytes);
  Future<Response> convertToPdf(List<String> imageBytes, String fitOption,
      String colorType, bool autoRotate);
  Future<Response> processFileToPDF(String fileBytes);
  Future<Response> processPdfToHTML(String pdfBytes);
}

class ApiProviderImpl implements ApiProvider {
  final Dio _dio = Dio(options);

  ApiProviderImpl(ApiInterceptor apiInterceptor) {
    _dio.interceptors.add(apiInterceptor);
  }

  static BaseOptions options = BaseOptions(
    baseUrl: "http://3.82.232.141/api/v1",

    contentType: Headers.formUrlEncodedContentType,
    //"application/json",
    followRedirects: false,
    //responseType: ResponseTy,
    responseType: ResponseType.plain,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
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
    return _dio.post('/convert/markdown/pdf', data: formData);
  }

  @override
  Future<Response> urlToPdf(String url) async {
    // create form data
    final formData = FormData.fromMap({
      "urlInput": url,
    });
    return _dio.post('/convert/url/pdf', data: formData);
  }

  @override
  Future<Response> processPdfToXML(String pdfBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
    });
    return _dio.post('/convert/pdf/xml', data: formData);
  }

  @override
  Future<Response> processPdfToWord(
      String pdfBytes, String outputFormat) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "outputFormat": outputFormat,
    });
    return _dio.post('/convert/pdf/word', data: formData);
  }

  @override
  Future<Response> processPdfToRTForTXT(
      String pdfBytes, String outputFormat) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "outputFormat": outputFormat,
    });
    return _dio.post('/convert/pdf/text', data: formData);
  }

  @override
  Future<Response> processPdfToPresentation(
      String pdfBytes, String outputFormat) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "outputFormat": outputFormat,
    });
    return _dio.post('/convert/pdf/presentation', data: formData);
  }

  @override
  Future<Response> pdfToPdfA(String pdfBytes, String outputFormat) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "outputFormat": outputFormat,
    });
    return _dio.post('/convert/pdf/pdfa', data: formData);
  }

  @override
  Future<Response> convertToImage(String pdfBytes, String imageFormat,
      String singleOrMultiple, String colorType, String dpi) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "imageFormat": imageFormat,
      "singleOrMultiple": singleOrMultiple,
      "colorType": colorType,
      "dpi": dpi,
    });
    return _dio.post('/convert/pdf/img', data: formData);
  }

  @override
  Future<Response> PdfToCsv(String pdfBytes, int pageId) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
      "pageId": pageId,
    });
    return _dio.post('/convert/pdf/csv', data: formData);
  }

  @override
  Future<Response> HtmlToPdf(String htmlBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        htmlBytes,
        filename: "input.html",
      ),
    });
    return _dio.post('/convert/html/pdf', data: formData);
  }

  @override
  Future<Response> convertToPdf(List<String> imageBytes, String fitOption,
      String colorType, bool autoRotate) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": imageBytes
          .map((byte) => MultipartFile.fromString(
                byte,
                filename:
                    "input.jpg", // Assuming image format is JPG, adjust as needed
              ))
          .toList(),
      "fitOption": fitOption,
      "colorType": colorType,
      "autoRotate": autoRotate,
    });
    return _dio.post('/convert/img/pdf', data: formData);
  }

  @override
  Future<Response> processFileToPDF(String fileBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        fileBytes,
        filename: "input.file", // Adjust filename based on actual file type
      ),
    });
    return _dio.post('/convert/file/pdf', data: formData);
  }

  @override
  Future<Response> processPdfToHTML(String pdfBytes) async {
    // create form data
    final formData = FormData.fromMap({
      "fileInput": MultipartFile.fromString(
        pdfBytes,
        filename: "input.pdf",
      ),
    });
    return _dio.post('/convert/pdf/html', data: formData);
  }
}

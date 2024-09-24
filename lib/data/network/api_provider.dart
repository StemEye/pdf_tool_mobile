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
}

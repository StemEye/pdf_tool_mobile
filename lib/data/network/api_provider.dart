import 'package:dio/dio.dart';
import 'api_interceptor.dart';

/// Created by Babar on 2/25/2022.
abstract class ApiProvider {
  Future<Response> markdownToPdf(String markdown);
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
}

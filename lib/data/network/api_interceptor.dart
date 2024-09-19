import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

/// Created by Babar on 2/25/2022.
class ApiInterceptor extends Interceptor {
  
  //late Logger logger;
  int maxRetries;
  int retryInterval;
  ApiInterceptor(
      {
      //required this.logger,
      this.maxRetries = 3,
      this.retryInterval = 1000});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    if (options.data != null && options.data is! FormData) {
      print(
          "Body: ${jsonEncode(options.data)}, path: ${options.path}, option:${options.headers}");
    } else {
      print(
          '${options.baseUrl} |  ${options.path} | ${options.queryParameters}, , option:${options.headers}');
    }

    //options.baseUrl = DateTime.now().timeZoneName == 'PKT'?(getX.Get.find<SharedPreferencesManager>().getBool(SharedPreferencesManager.keyIslogIn)??false)?'https://jazz-server.secureteen.com.pk/':'http://157.175.4.199:3300':'https://dashboard.secureteen.com';

/*    final accessToken = sharedPreferencesManager
        .getString(SharedPreferencesManager.keyAccessToken);
    if (accessToken != null) {
      options.headers.addAll({
        "Authorization": "Bearer $accessToken",
      });
    }*/

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "Response: ${response.statusCode} ${response.realUri} ${response.data}");
    try {
      response.data = jsonDecode(response.data);
      //todo handle all error here
      /*if (response.data['code'] != 100) {
        return handler.reject(error);
      }*/
    } catch (e) {
      return handler.next(response);
    }
    return handler.next(response);
  }


  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    int retries = 0;
    print(
        "<-- ${err.message} ${(err.response != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL')}");
    print("${err.response != null ? err.response!.data : 'Unknown Error'}");
    print("<-- End error");
    while (retries < maxRetries && _shouldRetry(err)) {
      retries++;
      await Future.delayed(Duration(milliseconds: retryInterval));
      try {
        return await Dio().fetch(err.requestOptions);
      } catch (e) {
        err = e as DioException;
      }
    }

    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    // You can customize this method to determine if you should retry based on the error type.
    return err.error is SocketException ||
        err.type == DioException.receiveTimeout ||
        err.type == DioException.sendTimeout;
  }
}


import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:time_dignitor_task/Utils/sharedPeferences.dart';

class ApiService{
  static const String BASE_URL = "https://dummyjson.com/";
  String? _authToken;
  SharedPre sp = SharedPre();

  final Dio _dio = Dio(
      BaseOptions(
        contentType: "application/json",
        baseUrl: BASE_URL,
        connectTimeout: Duration(seconds: 30000),
        receiveTimeout: Duration(seconds: 30000),
      )
  );

  ApiService()  { // Default Constructor initialize dio variable, token and add interceptor in it.

    _dio.interceptors.addAll(
      [
        InterceptorsWrapper(
          onRequest:(options, handler) async {
            _authToken = await sp.getAccessToken();
            print("This is form service token $_authToken");
            if (_authToken != null) {
              options.headers['Authorization'] = 'Bearer $_authToken';
            }
            return handler.next(options);
          },
        ),
        // Then add the logger
        PrettyDioLogger(
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      ]
    );
  }

  Dio get sendRequest => _dio;
}
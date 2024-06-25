import 'package:dio/dio.dart';

import 'dio_helper.dart';

class BaseHttpClient {
  static late final Dio dio;

  static void init() {
    final BaseOptions options = BaseOptions(
      baseUrl: "",
      sendTimeout: const Duration(seconds: 120),
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
    );

    dio = Dio()
      ..options = options
      ..interceptors.add(DIOHelper.i.defaultInterceptor);
  }
}

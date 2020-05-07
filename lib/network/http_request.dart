import 'package:dio/dio.dart';

class HttpRequest {
  // 1.创建实例对象
  static BaseOptions baseOptions = BaseOptions(connectTimeout: 5000);
  static Dio dio = Dio(baseOptions);

  static Future<T> request<T>(String url, {
                        String method = "get",
                        connectTimeout = "5000",
                        Map<String, dynamic> params}) async {
    // 1.单独相关的设置
    Options options = Options();
    options.method = method;

    // 2.发送网络请求
    try {
      Response response = await dio.request<T>(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch (e) {
      throw e;
    }
  }
}
import 'package:dio/dio.dart';

class HttpRequest {
  // 1.创建实例对象
  static BaseOptions baseOptions = BaseOptions(connectTimeout: 1000 * 30);
  static Dio dio = Dio(baseOptions);

  static Future<Response> request(String url, {
                        String method = "get",
                        Map<String, dynamic> params}) async {
    // 1.单独相关的设置
    Options options = Options();
    options.method = method;

    // 2.发送网络请求
    try {
      Response response = await dio.request(url, queryParameters: params, options: options);
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }
  static Future<List<Response>> requestMerge(String url,String url2, {
    String method = "get",
    Map<String, dynamic> p1,Map<String, dynamic> p2}) async {

    // 1.单独相关的设置
    Options options = Options();
    options.method = method;
    try {
      List<Response> response = await Future.wait(
          [dio.get(url), dio.get(url2)]);
      return response;
    }on DioError catch (e){
      throw e;
    }
  }
}
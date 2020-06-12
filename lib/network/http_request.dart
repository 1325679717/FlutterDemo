import 'package:dio/dio.dart';

class HttpRequest {
  static final HttpRequest _singleton = HttpRequest._init();
   Dio _dio;
  HttpRequest._init() {
    // 1.创建实例对象
    BaseOptions baseOptions = BaseOptions(connectTimeout: 1000 * 30);
    _dio = Dio(baseOptions);
  }
  factory HttpRequest() {
    return _singleton;
  }
   void putCookie(String cookie){
    Map<String,dynamic> _headers = new Map();
    _headers["Cookie"] = cookie;
    _dio.options.headers.addAll(_headers);
  }

   Future<Response> request(String url, {
                        String method = "get",
                        Map<String, dynamic> params}) async {
    // 1.单独相关的设置
    Options options = Options();
    options.method = method;

    // 2.发送网络请求
    try {
      print("HttpRequest headers = ${_dio.options.headers}");
      Response response = await _dio.request(url, queryParameters: params, options: options);
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }
   Future<List<Response>> requestMerge(String url,String url2, {
    String method = "get",
    Map<String, dynamic> p1,Map<String, dynamic> p2}) async {

    // 1.单独相关的设置
    Options options = Options();
    options.method = method;
    try {
      List<Response> response = await Future.wait(
          [_dio.get(url), _dio.get(url2)]);
      return response;
    }on DioError catch (e){
      throw e;
    }
  }
}
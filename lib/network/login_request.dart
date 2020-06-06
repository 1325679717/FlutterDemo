import 'dart:collection';

import 'package:flutter_app1223/model/LoginInfo.dart';

import 'http_request.dart';

class LoginRequest{
  Future<LoginInfo> login(String userName,String pwd) async{
    final url = "https://www.wanandroid.com/user/login";
    HashMap<String, dynamic> p = new HashMap();
    p["username"] = userName;
    p["password"] = pwd;
    final response = await HttpRequest.request(url,method: "post",params: p);
    final result = response.data;
    final data = result["data"];
    LoginInfo info = LoginInfo.fromJson(data);
    return info;
  }
}
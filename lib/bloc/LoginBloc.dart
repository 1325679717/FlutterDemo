import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app1223/network/login_request.dart';

class LoginBloc{

  StreamController<String> _controller = StreamController<String>();
//  Sink<String> get loginSink => _controller.sink;

//  Stream<String> get loginStream => _controller.stream;
  LoginRequest _request;
  LoginBloc(){
    _request = new LoginRequest();
  }
  void login(BuildContext context,String userName,String pwd){
    _request.login(userName, pwd).then((value) {
        print("LoginBloc value $value");
        Navigator.of(context).pop(null);
    });
  }
  void dispose(){
    _controller.close();
  }
}
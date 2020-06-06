


import 'package:flutter/material.dart';
import 'package:flutter_app1223/bloc/LoginBloc.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}
class LoginState extends State<Login>{
  final userNameController = TextEditingController();
  final pwdController = TextEditingController();

  final LoginBloc loginBloc = new LoginBloc();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body:Container(
        child: Center(
          child:Column(
            children: <Widget>[
              TextField(
                controller: userNameController,
                decoration:InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    labelText:"用户名"
                ),

              ),
              TextField(
                controller: pwdController,
                decoration:InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText:"密码"
                ),

                obscureText: true,
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("登录"),
                onPressed: (){
                  loginBloc.login(context,userNameController.text, pwdController.text);
//                  print("MaterialButton userName:${userNameController.text},pwd:${pwdController.text}");
                },

              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }
}
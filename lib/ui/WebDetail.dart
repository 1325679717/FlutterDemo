import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1223/model/ArticleInfo.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebDetail extends StatelessWidget{
  ArticleInfo _articleInfo;
  WebDetail(ArticleInfo _articleInfo){
    this._articleInfo = _articleInfo;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:true,
        title:Text(_articleInfo.title)
      ),
    body: WebviewScaffold(

    url: _articleInfo.link
    ),
    );

  }

}
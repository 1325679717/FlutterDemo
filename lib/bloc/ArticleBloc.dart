import 'dart:async';

import 'package:flutter_app1223/model/ArticleInfo.dart';
import 'package:flutter_app1223/network/home_request.dart';

class ArticleBloc{
  StreamController<List<ArticleInfo>> _controller = StreamController<List<ArticleInfo>>();
  Sink<List<ArticleInfo>> get articleSink => _controller.sink;

  Stream<List<ArticleInfo>> get articleStream => _controller.stream;


  StreamController<int> _actionController = StreamController<int>();
  StreamSink<int> get articleData => _actionController.sink;


  HomeRequest request;
  ArticleBloc(){

    request = new HomeRequest();

    _actionController.stream.listen((data){
      request.getArticleList(data).then((result){
        _controller.add(result);
      });
    });
  }
  void dispose(){
    _actionController.close();
    _controller.close();

  }
}
import 'dart:async';

import 'package:flutter_app1223/model/ArticleInfo.dart';
import 'package:flutter_app1223/model/BannerInfo.dart';
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
//    request.getHomeAllList().then((value){
//      final data = value[0].data["data"];
//      if(data == null){
//        return null;
//      }
//      final datas = data["datas"];
//      List<ArticleInfo> articles = [];
//      for (var d in datas) {
//        articles.add(ArticleInfo.fromJson(d));
//      }
//
//      final banJson = value[1].data["data"];
//      List<BannerInfo> bans = [];
//      for(var info in banJson){
//        bans.add(BannerInfo.fromJson(info));
//      }
//
////      setState(() {
////        banners.addAll(bans);
////        list.add(new ArticleInfo());
////        list.addAll(articles);
////      });
//    });

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
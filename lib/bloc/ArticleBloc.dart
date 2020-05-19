import 'dart:async';

import 'package:flutter_app1223/model/ArticleInfo.dart';
import 'package:flutter_app1223/model/BannerInfo.dart';
import 'package:flutter_app1223/network/home_request.dart';

class ArticleBloc{
  ///********首页列表///
  StreamController<List<ArticleInfo>> _controller = StreamController<List<ArticleInfo>>();
  Sink<List<ArticleInfo>> get articleSink => _controller.sink;

  Stream<List<ArticleInfo>> get articleStream => _controller.stream.asBroadcastStream();

  StreamController<int> _actionController = StreamController<int>();
  StreamSink<int> get articleData => _actionController.sink;

  ///********首页banner///

  StreamController<List<BannerInfo>> _banner = StreamController<List<BannerInfo>>();
  Sink<List<BannerInfo>> get _bannerSink => _banner.sink;

  Stream<List<BannerInfo>> get bannerStream => _banner.stream.asBroadcastStream();
  StreamController actionBanner = StreamController();
  StreamSink get actionData => actionBanner.sink;
  HomeRequest request;
  ArticleBloc(){

    request = new HomeRequest();

    _actionController.stream.listen((data){
      request.getArticleList(data).then((result){
        articleSink.add(result);
      });
    });

    actionBanner.stream.listen((event) {
      request.getArticleBanner().then((value){
        _bannerSink.add(value);
      });
    });
  }
  void dispose(){
    _actionController.close();
    _controller.close();

    _banner.close();
    actionBanner.close();
  }
}
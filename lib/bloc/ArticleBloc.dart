import 'dart:async';

import 'package:flutter_app1223/model/ArticleInfo.dart';
import 'package:flutter_app1223/model/BannerInfo.dart';
import 'package:flutter_app1223/network/home_request.dart';

class ArticleBloc{
  ///********首页列表///
  StreamController<List<ArticleInfo>> _controller = StreamController<List<ArticleInfo>>();
  Sink<List<ArticleInfo>> get articleSink => _controller.sink;

  Stream<List<ArticleInfo>> get articleStream => _controller.stream.asBroadcastStream();


  ///********首页banner///

  StreamController<List<BannerInfo>> _banner = StreamController<List<BannerInfo>>();
  Sink<List<BannerInfo>> get _bannerSink => _banner.sink;

  Stream<List<BannerInfo>> get bannerStream => _banner.stream.asBroadcastStream();

  HomeRequest request;
  ArticleBloc(){

    request = new HomeRequest();

  }
  void refresh(){
    request.getArticleList(0).then((result){
      articleSink.add(result);
    });
    request.getArticleBanner().then((result){
      _bannerSink.add(result);
    });
  }
  void load(int page){
    request.getArticleList(page).then((result){
      articleSink.add(result);
    });
  }
  void dispose(){
    _controller.close();

    _banner.close();
  }
}
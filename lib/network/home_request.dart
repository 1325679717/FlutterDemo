

import 'package:dio/dio.dart';
import 'package:flutter_app1223/model/ArticleInfo.dart';
import 'package:flutter_app1223/model/BannerInfo.dart';
import 'package:flutter_app1223/model/MovieInfo.dart';

import 'http_request.dart';

class HomeRequest {
  Future<List<MovieInfo>> getMovieTopList(int start, int count) async {
    // 1.拼接URL
    final url = "https://douban.uieee.com/v2/movie/top250?start=$start&count=$count";

    // 2.发送请求
    final result = await HttpRequest.request(url);

    // 3.转成模型对象
    final subjects = result["subjects"];
    List<MovieInfo> movies = [];
    for (var sub in subjects) {
      movies.add(MovieInfo.fromMap(sub));
    }

    return movies;
  }


  Future<List<ArticleInfo>> getArticleList(int start) async {
    // 1.拼接URL
    final url = "https://www.wanandroid.com/article/list/$start/json";

    // 2.发送请求
    final result = await HttpRequest.request(url);

    // 3.转成模型对象
    final data = result["data"];
    if(data == null){
      return null;
    }
    final datas = data["datas"];
    List<ArticleInfo> articles = [];
    for (var d in datas) {
      articles.add(ArticleInfo.fromJson(d));
    }

    return articles;
  }

  /**
   * banner
   */
  Future<List<BannerInfo>> getArticleBanner() async {
    // 1.拼接URL
    final url = "https://www.wanandroid.com/banner/json";

    // 2.发送请求
    final result = await HttpRequest.request(url);

    // 3.转成模型对象
    final data = result["data"];
    if(data == null){
      return null;
    }
    List<BannerInfo> articles = [];
    for (var d in data) {
      articles.add(BannerInfo.fromJson(d));
    }

    return articles;
  }

  Future<String> addCollect() async{
    final url = "https://www.wanandroid.com/lg/collect/add/json";

    final result = await HttpRequest.request(url);
    return result;
  }
  /**
   * bannerAll
   */
  Future<List<Response>> getHomeAllList() async {
    // 1.拼接URL
    final url = "https://www.wanandroid.com/article/list/0/json";
    final url2 = "https://www.wanandroid.com/banner/json";

    // 2.发送请求
    final result = await HttpRequest.requestMerge(url,url2);

    return result;
  }
}
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1223/model/ArticleInfo.dart';
import 'package:flutter_app1223/model/BannerInfo.dart';
import 'package:flutter_app1223/network/home_request.dart';
import 'package:flutter_app1223/ui/WebDetail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//class Article extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    throw UnimplementedError();
//  }
//}

class Article extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArticleState();
  }

}
void initData(State state,HomeRequest request,int page){

}
class ArticleState extends State<Article>{
  RefreshController _refreshController;

  int _currentPage = 0;
  List<ArticleInfo> list = [];
  List<BannerInfo> banners = [];
  HomeRequest request;
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    request = new HomeRequest();
    request.getHomeAllList().then((value){
      final data = value[0].data["data"];
      if(data == null){
        return null;
      }
      final datas = data["datas"];
      List<ArticleInfo> articles = [];
      for (var d in datas) {
        articles.add(ArticleInfo.fromJson(d));
      }

      final banJson = value[1].data["data"];
      List<BannerInfo> bans = [];
      for(var info in banJson){
        bans.add(BannerInfo.fromJson(info));
      }

      setState(() {
        banners.addAll(bans);
        list.add(new ArticleInfo());
        list.addAll(articles);
      });
    });

  }

  @override
  Widget build(BuildContext context) {

//    Widget buidRefresh(BuildContext context){
//      return EasyRefresh.custom(
//          enableControlFinishRefresh: false,
//          enableControlFinishLoad: true,
//          controller: _controller,
//          header: ClassicalHeader(),
//          footer: ClassicalFooter(),
//          onRefresh: () async{
//            _currentPage = 0;
//            request.getArticleList(_currentPage).then((value){
//              _controller.resetLoadState();
//              setState(() {
//                list.clear();
//                list.add(new ArticleInfo());
//                list.addAll(value);
//              });
//            });
//          },
//          onLoad: ()async{
//            _currentPage = _currentPage +1;
//            print("Article _currentPage = $_currentPage");
//            request.getArticleList(_currentPage).then((value){
//              _controller.finishLoad(success: true,noMore: value.length == 0);
//              setState(() {
//                list.addAll(value);
//              });
//            });
//          },
//          slivers: <Widget>[
//            SliverList(
//              delegate: SliverChildBuilderDelegate(
//                    (context,index){
//                  if(index == 0){
//                    return PageWidget(banners);
//                  }
//                  return ArticleItem(list[index]);
//                },
//                childCount: list.length,
//
//              ),
//            )
//          ]);
//    }
    Widget buildRefresh(BuildContext context){
      return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(builder: (BuildContext context,LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              }
              else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              }
              else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              }
              else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              }
              else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
          },
        ),
        controller: _refreshController,
        onRefresh: () async {
          _currentPage = 0;
          request.getArticleList(_currentPage).then((value) {
            _refreshController.refreshCompleted();
            setState(() {
              list.clear();
              list.add(new ArticleInfo());
              list.addAll(value);
            });
          });
        },
        child: ListView.builder(itemBuilder: (BuildContext context, int index){
                  if(index == 0){
                    return PageWidget(banners);
                  }
                  return ArticleItem(list[index]);
              },
              itemCount: list.length,
        ),
        onLoading: ()async{
            _currentPage = _currentPage +1;
            print("Article _currentPage = $_currentPage");
            request.getArticleList(_currentPage).then((value){
              _refreshController.loadComplete();
              setState(() {
                list.addAll(value);
              });
            });
          },
      );
    }
    return buildRefresh(context);
  }
}
/**
 *
 * pageView item
 *
 * */
class PageWidget extends StatelessWidget{
  List<BannerInfo> list;
  PageWidget(List<BannerInfo> list){
    this.list = list;
  }
  Widget buildBanner (BuildContext context){
    return PageView(
      children: list.map((banner)=> Container(
//          child: Text(banner.title,textAlign: TextAlign.center,),
//            child: Image.network(banner.imagePath)
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Image.network(
                    banner.imagePath,
                    fit:BoxFit.cover),
              ),
//
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 25,
                  decoration: BoxDecoration(color: Colors.black12),
                  margin: EdgeInsets.all(0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          banner.title,
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
//                    )
            ],
          ),
        ),
      )).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 230,
      alignment:AlignmentDirectional.center,
      child:buildBanner(context),
    );
  }

}


class ArticleItem extends StatefulWidget{
  ArticleInfo _articleInfo;
  ArticleItem(ArticleInfo _articleInfo){
    this._articleInfo = _articleInfo;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ItemState(_articleInfo);
  }

}
class ItemState extends State<ArticleItem>{
  ArticleInfo _articleInfo;
  TimelineInfo _info;
  ItemState(ArticleInfo _articleInfo){
    this._articleInfo = _articleInfo;
    _info = ZhInfo();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
      Navigator.push(context, MaterialPageRoute(
          builder: (_){
            return WebDetail(_articleInfo);
          }
      ));
    },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment:AlignmentDirectional.topStart,
              child: Stack(
                children: <Widget>[
                  Text(
                      _articleInfo.author == ""?_articleInfo.shareUser:_articleInfo.author,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                      )
                  ),
                  Align(
                    child: Text(
                        _articleInfo.niceShareDate,
//                        DateUtil.getDateStrByDateTime(_articleInfo.shareDate),
                        maxLines: 1,
                        style:TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                        )
                    ),
                    alignment: Alignment.centerRight,
                  ),


                ],
              ),
            ),

            Container(
                padding: EdgeInsets.only(top: 10),
                alignment:AlignmentDirectional.topStart,
                child:Text(
                    _articleInfo.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style:TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    )
                )
            ),
          ],
        ),
      ),
    );

  }

}
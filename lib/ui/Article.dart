import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1223/model/ArticleInfo.dart';
import 'package:flutter_app1223/model/BannerInfo.dart';
import 'package:flutter_app1223/network/home_request.dart';
import 'package:flutter_app1223/ui/Home.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
  EasyRefreshController _controller;
  int _currentPage = 0;
  List<ArticleInfo> list = [];
  List<BannerInfo> banners = [];
  HomeRequest request;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    request = new HomeRequest();
    request.getArticleList(_currentPage).then((value){
      setState(() {
        list.addAll(value);
      });
    });

  }
  @override
  Widget build(BuildContext context) {
      return EasyRefresh.custom(
          enableControlFinishRefresh: false,
          enableControlFinishLoad: true,
          controller: _controller,
          header: ClassicalHeader(),
          footer: ClassicalFooter(),
          onRefresh: () async{
            _currentPage = 0;
            request.getArticleList(_currentPage).then((value){
              _controller.resetLoadState();
              setState(() {
                list.clear();
                list.addAll(value);
              });
            });
          },
          onLoad: ()async{
            _currentPage = _currentPage +1;
            print("Article _currentPage = $_currentPage");
            request.getArticleList(_currentPage).then((value){
              _controller.finishLoad(success: true,noMore: value.length == 0);
              setState(() {
                list.addAll(value);
              });
            });
          },
          slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context,index){
                  if(index == 0){
                    return PageWidget();
                  }
                  return ArticleItem(list[index-1]);
                },
              childCount: list.length + 1
            ),
          )
    ]);
  }
}
/**
 *
 * pageView item
 *
 * */
class PageWidget extends StatelessWidget{
  List<String> list = ["狗子淼","狗子淼","狗子淼"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 150,
      alignment:AlignmentDirectional.center,
      child: PageView(
        children: list.map((content)=> Container(
          child: Text(content,textAlign: TextAlign.center,),
        )).toList(),
      ),
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
  ItemState(ArticleInfo _articleInfo){
    this._articleInfo = _articleInfo;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
            alignment:AlignmentDirectional.topStart,
             child: Text(
                 _articleInfo.author == ""?_articleInfo.shareUser:_articleInfo.author,
                 overflow: TextOverflow.ellipsis,
                 maxLines: 1,
                 style:TextStyle(
                     fontSize: 12,
                     color: Colors.grey
                 )
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
    );
  }

}
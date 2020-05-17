import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1223/bloc/ArticleBloc.dart';
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

  ArticleBloc _articleBloc;
  @override
  void initState() {
    super.initState();
    _articleBloc = new ArticleBloc();

    _refreshController = RefreshController(initialRefresh: false);

    _articleBloc.articleData.add(_currentPage);


  }

  @override
  Widget build(BuildContext context) {


    Widget buildRefresh(BuildContext context, AsyncSnapshot<List<ArticleInfo>> snapshot){
      list.addAll(snapshot.data);
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
        onRefresh:()async{
          _articleBloc.articleData.add(0);
        },
        child: ListView.builder(itemBuilder: (BuildContext context, int index){
                  if(index == 0){
                    return PageWidget(banners);
                  }
                  return ArticleItem(list[index]);
              },
              itemCount: list.length,
        ),
        onLoading:()async{
          _articleBloc.articleData.add(_currentPage + 1);
        }

      );
    }
    return StreamBuilder(
        stream: _articleBloc.articleStream,
        builder: (BuildContext context, AsyncSnapshot<List<ArticleInfo>> snapshot){

            return buildRefresh(context,snapshot);
        },
    );
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
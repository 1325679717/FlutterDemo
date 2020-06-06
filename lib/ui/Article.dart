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

import 'Login.dart';

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
//  List<BannerInfo> banners = [];

  ArticleBloc _articleBloc;
  bool isRefresh = true;
  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    _articleBloc = new ArticleBloc();

    _refreshController = RefreshController(initialRefresh: false);

    _articleBloc.refresh();
    /**
     * banner
     */
    Widget buildBanner (BuildContext context, List<BannerInfo> banners){
      return AspectRatio(
        aspectRatio: 16/9,
        child:PageView(
        children: banners.map((banner)=> Container(
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
                            overflow: TextOverflow.ellipsis,
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
      )

      );
    }
    /**
     * item
     */
    Widget buildItem(BuildContext context, int index){
      ArticleInfo _articleInfo = list[index];
      return Container(
        child: GestureDetector(
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
                    child: Row(
                        children: <Widget>[
                          Expanded(
                            child:  Text(
                                _articleInfo.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                                style:TextStyle(
                                    fontSize: 15,
                                    color: Colors.black
                                )
                            ),
                          ),

                          Align(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (_){
                                        return Login();
                                      }
                                  ));
                                },
                                child: Icon(_articleInfo.collect?Icons.star:Icons.star_border),
                              ),
                              alignment: Alignment.centerRight
                          )
                        ],
                      )
                ),
              ],
            ),
          ),
        ),
      );
    }
    Widget buildRefresh(BuildContext context, List<ArticleInfo> list){

      return  SmartRefresher(
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
          isRefresh = true;
          _articleBloc.refresh();
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: StreamBuilder(
                        stream: _articleBloc.bannerStream,
                        builder: (BuildContext context,AsyncSnapshot<List<BannerInfo>> snapshot){
                          if(snapshot == null || snapshot.data == null){
                            return Container(
                              height: 0,
                            );
                          }else {
                            return buildBanner(context, snapshot.data);
                          }
                        },
              )
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(buildItem,childCount:list.length),
            )
          ],
        ),

//        ),
        onLoading:()async{
          isRefresh = false;
          _articleBloc.load(_currentPage + 1);
        }

      );
    }
    return StreamBuilder(
        stream: _articleBloc.articleStream,
        builder: (BuildContext context, AsyncSnapshot<List<ArticleInfo>> snapshot){
          if(snapshot != null && snapshot.data != null) {
            if(isRefresh){
              list.clear();
              _refreshController.refreshCompleted();
            }else{
              _refreshController.loadComplete();
            }
            list.addAll(snapshot.data);
          }
          return buildRefresh(context,list);
        },
    );
  }
  @override
  void dispose() {
    _articleBloc.dispose();
    super.dispose();
  }

}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1223/dialog/LoadingPage.dart';
import 'package:flutter_app1223/model/MovieInfo.dart';
import 'package:flutter_app1223/network/home_request.dart';
import 'package:flutter_app1223/ui/item/HomeListItem.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HomeContent(context);
  }
}
class HomeContent extends StatefulWidget{
  BuildContext context;
  HomeContent(BuildContext context){
    this.context = context;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState(context);
  }

}
class HomeState extends State<HomeContent> with AutomaticKeepAliveClientMixin {
  BuildContext context;
  HomeState(BuildContext context){
    this.context = context;
  }
  List<MovieInfo> data = new List<MovieInfo>();
  HomeRequest request = new HomeRequest();
  LoadingPage loadingPage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingPage = new LoadingPage(context);
    initData();
  }
  void initData(){
    /// Schedule a callback for the end of this frame

    request.getMovieTopList(0, 20).then((result){
      setState(() {
        data.addAll(result);
//        loadingPage.close();
//        EasyLoading.dismiss();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index){
          return DouListItem(data[index]);
        },
      itemCount: data.length,
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1223/dialog/LoadingPage.dart';
import 'package:flutter_app1223/model/MovieInfo.dart';
import 'package:flutter_app1223/network/home_request.dart';
import 'package:flutter_app1223/ui/item/DouListItem.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("狗子转"),
      ),
      body: DouContent(context),
    );
  }
}
class DouContent extends StatefulWidget{
  BuildContext context;
  DouContent(BuildContext context){
    this.context = context;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DouState(context);
  }

}
class DouState extends State<DouContent>{
  BuildContext context;
  DouState(BuildContext context){
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
//    loadingPage.show();
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      EasyLoading.show(status: 'loading...');
//    });
//    List<MovieInfo> list = new List<MovieInfo>();
//    for(int i = 0; i < _count;i++){
//      MovieInfo movieInfo = new MovieInfo();
//      movieInfo.name = "狗子传说";
//      movieInfo.avtar = "https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg";
//      movieInfo.actor = "狗子/蛤蟆";
//      list.add(movieInfo);
//    }
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

}
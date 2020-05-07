import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1223/ui/Article.dart';
import 'package:flutter_app1223/ui/Knowledge.dart';

import '../ui/Home.dart';

class BottomNavigationWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomNavigationWidgetState();
  }
}
class BottomNavigationWidgetState extends State<BottomNavigationWidget>{
  var _currentIndex = 0;
  var pages;
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    pages = [Article(),Knowledge(),Home(),Home(),Home()];
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels:true,
        selectedItemColor: Color(0xffff8635),
        unselectedItemColor: Color(0xff666666),
        type: BottomNavigationBarType.fixed,

          items:[
            BottomNavigationBarItem(
              backgroundColor:Colors.blue,
              icon: Icon(Icons.home),
              title: Text("主页")
            ),
            BottomNavigationBarItem(
                backgroundColor:Colors.blue,
                icon: Icon(Icons.business),
                title: Text("广场")
            ),
            BottomNavigationBarItem(
                backgroundColor:Colors.blue,
                icon: Icon(Icons.camera),
                title: Text("公众号")
            ),
            BottomNavigationBarItem(
                backgroundColor:Colors.blue,
                icon: Icon(Icons.dashboard),
                title: Text("体系")
            ),
            BottomNavigationBarItem(
                backgroundColor:Colors.blue,
                icon: Icon(Icons.assignment),
                title: Text("项目")
            )
          ],
        currentIndex: _currentIndex,
        onTap: (i){
          switchTab(i);
        },
      ),
      body:IndexedStack(
        index: _currentIndex,
        children: pages,
      ) ,
    );
  }
  void switchTab(int index){
    setState(() {
      if(index != _currentIndex) {
        _currentIndex = index;
      }
    });
  }
}
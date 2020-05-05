import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1223/model/MovieInfo.dart';

class DouListItem extends StatelessWidget{
  MovieInfo _movieInfo;
  DouListItem(MovieInfo _movieInfo){
    this._movieInfo = _movieInfo;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 120,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))
      ),
      child: Row(
            children: <Widget>[
              Container(
                width: 70,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      _movieInfo.avtar
                    )
                  )
                ),//图片
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            _movieInfo.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        Text(
                            _movieInfo.actor,
                          style: TextStyle(
                              fontSize: 15.0
                          ),
                        )
                      ]
                  ),
                ),
              ),//内容
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/wish.png",
                        width: 32,
                        height: 32,
                      ),
                      Text(
                        "想看",
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 15.0
                        ),
                      )
                    ],
                  ),
                )

            ],
      ),
    );
  }

}
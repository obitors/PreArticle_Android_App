import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';

class Contents extends StatefulWidget {
  @override
  _ContentsState createState() => _ContentsState();
  Contents({@required this.onPressed});
  final GestureTapCallback onPressed;
}

double percent = 50;

class _ContentsState extends State<Contents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6e9bdf),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {}),
        centerTitle: true,
        title: Text(
          'Contents',
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 25, top: 30),
                  child: Text(
                    '102 Chapters',
                    style: TextStyle(
                      color: Color(0xff6e9bdf),
                      fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, top: 0, right: 25),
                  child: RoundedProgressBar(
                    childLeft: Text("$percent%",
                        style: TextStyle(color: Colors.white)),
                    style: RoundedProgressBarStyle(
                      borderWidth: 0,
                      widthShadow: 0,
                      colorProgress: Color(0xff6e9bdf),
                      backgroundProgress: Colors.grey[200],
                    ),
                    height: 7,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    borderRadius: BorderRadius.circular(24),
                    percent: percent,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

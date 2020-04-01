import 'package:flutter/material.dart';
import 'package:prearticle/Configuration/app_config.dart';

class Contents extends StatefulWidget {
  @override
  _ContentsState createState() => _ContentsState();
  Contents({@required this.onPressed});
  final GestureTapCallback onPressed;
}

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
          Container(
            height: 100,
            width: SizeConfig.blockSizeHorizontal * 100,
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
                  padding: EdgeInsets.only(left: 25, top: 20),
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
                  padding: EdgeInsets.only(left: 25, top: 25, right: 25),
                  child: Container(
                  height: 7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: 7,
                    width: SizeConfig.blockSizeHorizontal * 5,
                    decoration: BoxDecoration(
                      color: Color(0xff6e9bdf),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

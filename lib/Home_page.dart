import 'package:flutter/material.dart';
import 'package:prearticle/Chapters/Contents.dart';
import 'package:prearticle/Chapters/chapterData.dart';
import 'package:prearticle/Chapters/chapterName.dart';
import 'package:prearticle/Chapters/textSlider.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6e9bdf),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          ''
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
      body: Column (
        children: <Widget>[
          chapter_Name(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              ),
              child: chapter_data(),
            ),
          ),
        ],
      ),
    );
  }
}
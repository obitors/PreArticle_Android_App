import 'package:flutter/material.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Screens/Login_Page.dart';
import 'package:prearticle/Widgets/chapterData.dart';
import 'package:prearticle/Widgets/chapterName.dart';
import 'dart:io';
import 'package:prearticle/objects/Chapter_Data_Class.dart';

class ReadingPage extends StatefulWidget {
  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {

  @override
  Widget build(BuildContext context) {
    final Data data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xff6e9bdf),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loginPage(onPressed: () {  },)),
              );
            }),
        centerTitle: true,
        title: Text(
          '',
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
          chapter_Name(name: data.name),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: chapter_data(
                link: data.data,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


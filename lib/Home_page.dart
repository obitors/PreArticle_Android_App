import 'package:flutter/material.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: <Widget>[
          Container(
            height: 90.0,
            color: Color(0xff6E9BDF),
          ),
        ]
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:prearticle/Chapter_Data_Class.dart';

class chapter_Name extends StatefulWidget {
  String name;
  chapter_Name({this.name});

  @override
  _chapter_NameState createState() => _chapter_NameState();
}

class _chapter_NameState extends State<chapter_Name> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      width: 500,
      color: Color(0xff6E9BDF),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Text (
        widget.name,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      ),
    );
  }
}
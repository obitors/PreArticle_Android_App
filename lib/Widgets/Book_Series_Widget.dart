import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookSeriesWidget extends StatefulWidget {
  BookSeriesWidget({Key key}) : super(key: key);

  @override
  _BookSeriesWidgetState createState() => _BookSeriesWidgetState();
}

class _BookSeriesWidgetState extends State<BookSeriesWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: EdgeInsets.only(right: 10,left: 10),
        child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15)
        ),
      ),  
      );
     },
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:prearticle/100ways.dart';

class Hundred_ways extends StatefulWidget {
  Hundred_ways({Key key}) : super(key: key);
  

  @override
  _Hundred_waysState createState() => _Hundred_waysState();
}

class _Hundred_waysState extends State<Hundred_ways> {
  final String url = 'https://github.com/obitors/PreArticle_Android_App/blob/master/Data/100%20Ways.json';
  List data;
  double percen=30;
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<List<ways>> getJsonData() async {
    var response = await http.get(url);
    print(response.body);
    var way = List<ways>();
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['results'];
      for (var i in convertDataToJson)
      {
        way.add(ways.fromJson(i));
      }
    });
    return "success";
  }

  

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: data == null? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsets.only(left: 25, right: 25, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Color(0xff6e9bdf),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  data[index]['name'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '10 minutes to Complete',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            );
        },
      ),
    );
  }
}
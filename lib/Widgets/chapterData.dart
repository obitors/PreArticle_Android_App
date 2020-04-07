import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';

class chapter_data extends StatefulWidget {
  final String link;
  chapter_data({this.link});
  @override
  _chapter_dataState createState() => _chapter_dataState(url: link);
}

double fontsize = 15;
double sliderValue = 0.0;
var fontSizeVar = 'small';

class _chapter_dataState extends State<chapter_data> {
  String url;
  _chapter_dataState({this.url});
  double percen = 30;

  List data;
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(url);
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['results'];
    });
    return "success";
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: FutureBuilder(
            future: getJsonData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Column(
                  children: <Widget>[
                    Expanded(
                  flex: 1,
                    child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    width: double.infinity,
                    child: PlaceholderLines(
                      count: 20,
                      animate: true,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                ),
                  ],
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: ListView.builder(
                        itemCount: data == null ? 0 : data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SelectableText(
                            data[index]['para'],
                            style: TextStyle(
                              fontSize: fontsize,
                              color: Colors.grey[600],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 0,
            ),
            child: Slider(
              value: sliderValue,
              min: 0,
              max: 4,
              divisions: 4,
              onChanged: (value) {
                setState(
                  () {
                    sliderValue = value;
                    if (sliderValue < 1) {
                      fontsize = 15;
                      fontSizeVar = 'extra small';
                    }
                    if (sliderValue >= 1 && sliderValue < 2) {
                      fontsize = 18;
                      fontSizeVar = 'small';
                    }
                    if (sliderValue >= 2 && sliderValue < 3) {
                      fontsize = 21;
                      fontSizeVar = 'medium';
                    }
                    if (sliderValue >= 3 && sliderValue < 4) {
                      fontsize = 24;
                      fontSizeVar = 'large';
                    }
                    if (sliderValue >= 4 && sliderValue < 5) {
                      fontsize = 27;
                      fontSizeVar = 'Extra Large';
                    }
                    if (sliderValue >= 5) {
                      fontsize = 30;
                      fontSizeVar = 'Extra Large';
                    }
                  },
                );
              },
            ),
          ),
        ),
        Container(
          child: Padding(
              padding: EdgeInsets.only(
                left: 35,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    'Font Size: ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    fontSizeVar,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

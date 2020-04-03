import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class chapter_data extends StatefulWidget {
  chapter_data({Key key}) : super(key: key);

  @override
  _chapter_dataState createState() => _chapter_dataState();
}

double fontsize = 15;
double sliderValue = 0.0;
var fontSizeVar = 'small';



class _chapter_dataState extends State<chapter_data> {
  @override

    final String url = 'https://raw.githubusercontent.com/obitors/PreArticle_Android_App/master/Data/Chapter_1.json';
  List data;
  double percen=30;
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
        Container(
          width: 500,
          height: 742,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: ListView.builder(
                itemCount: data == null? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                return Text(
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

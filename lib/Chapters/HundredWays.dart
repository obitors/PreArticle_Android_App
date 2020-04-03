import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:prearticle/Home_page.dart';

class Hundred_ways extends StatefulWidget {
  Hundred_ways({Key key}) : super(key: key);

  @override
  _Hundred_waysState createState() => _Hundred_waysState();
}

class Data {
  final String name;
  final String data;
  final String readTime;
  final String speechTime;
  final String words;
  final String characters;

  Data({this.name, this.data, this.readTime, this.speechTime, this.words, this.characters});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'] as String,
      data: json['data'] as String,
      readTime: json['readTime'] as String,
      speechTime: json['speechTime'] as String,
      words: json['words'],
      characters: json['characters'],
    );
  }
}

class _Hundred_waysState extends State<Hundred_ways> {

  final String url =
      'https://raw.githubusercontent.com/obitors/PreArticle_Android_App/master/Data/100Ways.json';
  List data;
  double percen = 30;
  @override


  Future<String> getJsonData() async {
    var response = await http.get(url);
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body).cast<Map<String, dynamic>>();
      data = convertDataToJson['results'];
    });
    return "success";
  }


  List<Data> _data = List<Data>();

  Future<List<Data>> fetchNotes() async {
    var url = 'https://raw.githubusercontent.com/obitors/PreArticle_Android_App/master/Data/100Ways.json';
    var response = await http.get(url);
    
    var datas = List<Data>();
    
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        datas.add(Data.fromJson(noteJson));
      }
    }
    return datas;
  }

  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _data.addAll(value);
      });
    });
    super.initState();
  }







  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _data == null ? 0 : _data.length,
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Homepage(),
                                        settings: RouteSettings(
                                            arguments: data[index])),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    _data[index].name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
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
              ));
        },
      ),
    );
  }
}

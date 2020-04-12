import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prearticle/objects/Chapter_Data_Class.dart';
import 'package:epub_kitty/epub_kitty.dart';

class Hundred_ways extends StatefulWidget {
  Hundred_ways({Key key}) : super(key: key);

  @override
  _Hundred_waysState createState() => _Hundred_waysState();
}

class _Hundred_waysState extends State<Hundred_ways> {
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
      return datas;
    } else {
      return List<Data>();
    }
  }

  void initState() {
    this.widget;
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
                              onTap: () async {
            
                                String androidBookPath = 'https://epubdrive.com/content/wings-of-fire-epub-download-162740658.epub';
                                EpubKitty.setConfig(
                                    "iosBook", "#32a852", "vertical", true);
                                EpubKitty.open(androidBookPath);
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
            ),
          );
        },
      ),
    );
  }
}

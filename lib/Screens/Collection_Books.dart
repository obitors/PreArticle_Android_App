import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prearticle/Screens/Book_Details.dart';
import 'package:prearticle/Widgets/HundredWays.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';

class CollectionBooks extends StatefulWidget {
  CollectionBooks({Key key}) : super(key: key);

  @override
  _CollectionBooksState createState() => _CollectionBooksState();
}

double percent = 50;

class _CollectionBooksState extends State<CollectionBooks> {
  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xff6e9bdf),
      /*appBar:  AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {}),
        centerTitle: true,
        title: Text(
          name,
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
      ), */
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 10, right: 10, top:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            /* GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 25,
                                width: 50,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                                )
                              )
                            ), */
                             IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          }), 
                                       
                              
                            Text(
                              name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        /* IconButton(
                            icon: Icon(Icons.search, color: Colors.white),
                            onPressed: null), */
                      ],
                    ),
                  ),
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 25, top: 30),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Color(0xff6e9bdf),
                      fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, top: 0, right: 25),
                  child: RoundedProgressBar(
                    childLeft: Text("$percent%",
                        style: TextStyle(color: Colors.white)),
                    style: RoundedProgressBarStyle(
                      borderWidth: 0,
                      widthShadow: 0,
                      colorProgress: Color(0xff6e9bdf),
                      backgroundProgress: Colors.grey[200],
                    ),
                    height: 7,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    borderRadius: BorderRadius.circular(24),
                    percent: percent,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection("Books")
                    .where("Collection", isEqualTo: name)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData? ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding:
                            EdgeInsets.only(left: 25, right: 25, bottom: 15),
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
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        BookDetails(name: snapshot.data
                                                            .documents[index]
                                                        ['Name']),
                                                settings: RouteSettings(
                                                    arguments: snapshot.data
                                                            .documents[index]
                                                        ['Name'])),
                                          );
                                        },
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10, right: 10),
                                                  child: Container(
                                                    width: SizeConfig.blockSizeHorizontal * 100-125,
                                                    child: Text(
                                                      snapshot.data
                                                              .documents[index]
                                                          ['Name'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  snapshot.data
                                                              .documents[index]
                                                          ['Pages'],
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ):
                  Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prearticle/Screens/Book_Details.dart';
import 'package:prearticle/objects/Book_Data.dart';
import 'package:http/http.dart' as http;


class CardSwipe extends StatefulWidget {
  @override
  _CardSwipeState createState() => _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe> {


  List<Book> _data = List<Book>();
  Future<List<Book>> fetchNotes() async {
    var url = 'https://raw.githubusercontent.com/obitors/PreArticle_Android_App/master/lib/Data/collection.json';
    var response = await http.get(url);
    var datas = List<Book>();
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        datas.add(Book.fromJson(noteJson));
      }
      return datas;
    } else {
      return List<Book>();
    }
  }



  final pageController = PageController(viewportFraction: .8);
  final ValueNotifier<double> _pageNotifier = ValueNotifier(0.0);

  void _listener() {
    _pageNotifier.value = pageController.page;
    setState(() {});
  }


  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.addListener(_listener);
    });
    this.widget;
    fetchNotes().then((value) {
      setState(() {
        _data.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(30);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: Firestore.instance.collection("Books").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData? Stack(
            children: [
              PageView.builder(
                  itemCount: snapshot.data.documents.length,
                  //itemCount: snapshot.data,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    final lerp =
                        lerpDouble(0, 0, (index - _pageNotifier.value).abs());
                    double opacity = lerpDouble(
                        0.0, .3, (index - _pageNotifier.value).abs());
                    double heights = lerpDouble(size.height / 2,
                        size.height / 2.2, (index - _pageNotifier.value).abs());
                    if (opacity > 1.0) opacity = 1.0;
                    if (opacity < 0.0) opacity = 0.0;
                    return Transform.translate(
                      offset: Offset(0.0, lerp * 50),
                      child: Opacity(
                        opacity: (1 - opacity),
                        child: Align(
                          alignment: Alignment.center,
                          child: Card(
                            color: Colors.transparent,
                            borderOnForeground: true,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: borderRadius,
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: SizedBox(
                              height: heights,
                              width: size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  /* RaisedButton(
                                child: Text('Create Record'),
                                onPressed: () {
                                  getData();
                                },
                              ), */
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0,
                                          left: 20.0,
                                          right: 20.0,
                                          bottom: 20),
                                      /* child: ClipRRect(
                                          borderRadius: borderRadius,
                                          child: Hero(
                                            tag: 'bookCover',
                                            child: Image.network(
                                              snapshot.data.documents[index]
                                                  ['Image'],
                                              fit: BoxFit.cover,
                                            ),
                                          )), */
                                      child: Hero(tag: 'BookCover+$index', child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  BookDetails(),
                                                  settings: RouteSettings(
                                            arguments: snapshot.data.documents[index]['Name'])
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                            borderRadius: borderRadius,
                                            child: Image.network(
                                                snapshot.data.documents[index]['Image'],
                                                fit: BoxFit.cover,
                                              ),),
                                      ),)
                                    ),
                                  ),
                                  /*Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    movies[index].title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ):
          Container();
        },
      ),
    );
  }
  /* final databaseReference = Firestore.instance;
  void getData() {
    databaseReference
        .collection("Books")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void createRecord() async {
    await databaseReference.collection("Books").document("1").setData({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref = await databaseReference.collection("Books").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);
  } */

}

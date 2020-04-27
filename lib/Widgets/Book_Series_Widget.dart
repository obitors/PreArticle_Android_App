import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prearticle/Screens/Collection_Books.dart';
import 'package:prearticle/Screens/Contents_List.dart';

class BookSeriesWidget extends StatefulWidget {
  BookSeriesWidget({Key key}) : super(key: key);

  @override
  _BookSeriesWidgetState createState() => _BookSeriesWidgetState();
}

class _BookSeriesWidgetState extends State<BookSeriesWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("Book Series").snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return snapshot.hasData? Container(
          child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data.documents.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CollectionBooks(),
                                        settings: RouteSettings(
                                            arguments: snapshot.data.documents[index]['Name'])),
                                  );
            },
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  snapshot.data.documents[index]['Image'],
                  fit: BoxFit.cover,
                ),
              ),),
              Padding(padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(snapshot.data.documents[index]['Name'],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ),
              ),
                ],
              ),
            ),
          ),
        );
      },
    )
        ):
        Container();
      },
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epub_kitty/epub_kitty.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prearticle/Database/Downloads_Database.dart';
import 'package:prearticle/Providers/Details_Provider.dart';
import 'package:http/http.dart' as http;
import 'package:prearticle/Widgets/Downloading_Popup.dart';
import 'package:prearticle/objects/Book_Data.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  BookDetails({Key key}) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  Future startDownload(BuildContext context, String url, String filename,
      String imageUrl, var index1) async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      downloading(context, url, filename, imageUrl, index1);
    } else {
      downloading(context, url, filename, imageUrl, index1);
    }
  }

  downloading(BuildContext context, String fileUrl, String filename,
      String imageUrl, var index1) async {
    Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    if (Platform.isAndroid) {
      Directory(appDocDir.path.split("Android")[0] +
              "Android/data/com.obitors.prearticle")
          .create();
    }

    String filepath = Platform.isIOS
        ? appDocDir.path + "/$filename.epub"
        : appDocDir.path.split("Android")[0] +
            "Android/data/com.obitors.prearticle/files/$filename.epub";

    String imagepath = Platform.isIOS
        ? appDocDir.path + "/$filename.jpg"
        : appDocDir.path.split("Android")[0] +
            "Android/data/com.obitors.prearticle/files/$filename.jpg";

    print(filepath);
    print(imagepath);
    print(imageUrl);

    File epubfile = File(filepath);
    if (!await epubfile.exists()) {
      await epubfile.create();
    } else {
      await epubfile.delete();
      await epubfile.create();
    }

    File imagefile = File(imagepath);
    if (!await imagefile.exists()) {
      await imagefile.create();
    } else {
      await imagefile.delete();
      await imagefile.create();
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DownloadAlert(
        url: fileUrl,
        path: filepath,
      ),
    ).then((value) => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => DownloadAlert(
            url: imageUrl,
            path: imagepath,
          ),
        ).then((v) {
          if (v != null) {
            /* final databaseReference = Firestore.instance;
        var doc = Firestore.instance.collection("Books").snapshots();
        databaseReference
            .collection("Data")
            .getDocuments()
            .then((QuerySnapshot snapshot) {
          Provider.of<DetailsProvider>(context, listen: false).addDownload(
            {
              "id": snapshot.documents[index1]['ID'],
              "path": filepath,
              "size": v,
              "name": snapshot.documents[index1]['Name'],
              "author": snapshot.documents[index1]['Author'],
            },
          );
        }); */

            Provider.of<DetailsProvider>(context, listen: false).addDownload(
              {
                "id": filename,
                "path": filepath,
                "size": v,
                "name": filename,
                "author": filename,
                "image": imagepath,
              },
            );

            /* StreamBuilder (
          stream: Firestore.instance.collection("Books").snapshots() ,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return Container (
              child: Provider.of<DetailsProvider>(context, listen: false).addDownload(
            {
              "id": snapshot.data.documents[index1]['ID'],
              "path": filepath,
              "size": v,
              "name": snapshot.data.documents[index1]['Name'],
              "author": snapshot.data.documents[index1]['Author'],
            },
          ),
          );
          },
        ); */

            /* List<Book> _data = List<Book>();
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

        fetchNotes().then((value) {
          setState(() {
            _data.addAll(value);
          });
        });

        print(_data[index1].author);

        Provider.of<DetailsProvider>(context, listen: false).addDownload(
          {
            "id": _data[index1].name,
            "path": filepath,
            "size": v,
            "name": _data[index1].name,
            "author": _data[index1].author,
          },
        ); */
          }
        }));
  }

  bool done = true;
  var db = DownloadsDB();
  /* static final uuid = Uuid(); */

  List dls = List();
  getDownloads() async {
    List l = await db.listAll();
    setState(() {
      dls.addAll(l);
    });
  }

  checkDownload(String name) {
    for (int i=0; i<= dls.length; i++)
    {
      Map dl = dls[i];
      if (dl['name']==name)
      {
        return dl['path'];
      }
      else {
        return null;
      }
    }
  }

  
  @override
  void initState() {
    super.initState();
    getDownloads();
  }

  @override
  Widget build(BuildContext context) {
    final int index1 = ModalRoute.of(context).settings.arguments;
    return Consumer<DetailsProvider>(
      builder: (BuildContext context, DetailsProvider detailsProvider, Widget child) {
        return Scaffold(
      backgroundColor: Color(0xff6e9bdf),
      appBar: AppBar(
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: Text(
          'PreArticle',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: StreamBuilder(
        
        stream: Firestore.instance.collection("Books").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot,) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: 'BookCover0',
                                  child: Container (
                                    height: 230,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data.documents[index1]
                                            ['Image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          snapshot
                                              .data.documents[index1]['Name']
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data.documents[index1]
                                            ['Author'],
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 100,
                                        width: 250,
                                        child: ListView.builder(
                                          itemCount: snapshot
                                              .data
                                              .documents[index1]['Category']
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: EdgeInsets.only(top: 10, right: 10),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0x996e9bdf),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20, right: 20),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data.documents[
                                                                      index1]
                                                                  ['Category']
                                                              [index],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    height: 30,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Text('121 pages')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Center(
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color(0xff6e9bdf),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              
                              child: checkDownload(snapshot.data.documents[index1]['Name'] .replaceAll(" ", "_")
                                    .replaceAll(r"\'", "")) != null ?
                                    FlatButton(
                                onPressed: (){
                                  String path = checkDownload(snapshot.data.documents[index1]['Name'] .replaceAll(" ", "_")
                                    .replaceAll(r"\'", ""));
                                      EpubKitty.setConfig("androidBook", "#06d6a7","vertical",true);
                                      EpubKitty.open(path);
                                },
                                  child: Text(
                                  "Read Book",
                                  style: TextStyle(
                                  color: Colors.white,
                                ),
                                ),
                                ) :
                                    
                                    
                                    /* detailsProvider.downloaded
                                  ?  FlatButton(
                                onPressed: (){
                                  detailsProvider.getDownload(snapshot.data.documents[index1]['Name'] .replaceAll(" ", "_")
                                    .replaceAll(r"\'", "")).then((c){
                                    if(c.isNotEmpty){
                                      Map dl = c[0];
                                      String path = dl['path'];
                                      EpubKitty.setConfig("androidBook", "#06d6a7","vertical",true);
                                      EpubKitty.open(path);
                                    }
                                  });
                                },
                                child: Text(
                                  "Read Book",
                                ),
                              ): */
                              Center(child: RaisedButton(
                                elevation: 0,
                              onPressed: () => startDownload(
                                context,
                                snapshot.data.documents[index1]['File'],
                                snapshot.data.documents[index1]['Name']
                                    .replaceAll(" ", "_")
                                    .replaceAll(r"\'", ""),
                                snapshot.data.documents[index1]['Image'],
                                index1,
                              ),
                              color: Color(0xff6e9bdf),
                              child: Text('Add to Library',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),),
                            )
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
      },
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epub_kitty/epub_kitty.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Database/Downloads_Database.dart';
import 'package:prearticle/Providers/Details_Provider.dart';
import 'package:http/http.dart' as http;
import 'package:prearticle/Widgets/Downloading_Popup.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';

class BookDetails extends StatefulWidget {
  final String name;
  BookDetails({Key key, @required this.name}) : super(key: key);

  @override
  BookDetailsState createState() => BookDetailsState(newname: name);
}

enum downloaded { yes, no }

class BookDetailsState extends State<BookDetails> {
  String newname;
  BookDetailsState({this.newname});

  String downloadPath;
  downloaded _downloaded = downloaded.no;
  var db = DownloadsDB();
  List dls = List();

  /*  getDownloads() async {
    List l = await db.listAll();
    setState(() {
      dls.addAll(l);
    });
    
  } */

  String bookpath;

  checkDownload(String somename) async {
    List l = await db.listAll();
    setState(() {
      dls.addAll(l);
    });
    if (dls.isEmpty) {
      return null;
    } else {
      for (int i = 0; i < dls.length; i++) {
        Map dl = dls[i];
        if (dl['name'] == somename) {
          setState(() {
            downloadPath = dl['path'];
            print(downloadPath);
            /* return dl['path']; */
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    /* getDownloads(); */
    print(widget.name.replaceAll(" ", "_").replaceAll(r"\'", ""));
    String somename = widget.name.replaceAll(" ", "_").replaceAll(r"\'", "");
    checkDownload(somename);
  }

  @override
void dipose(){
    super.dispose();
}

  Future startDownload(BuildContext context, String url, String filename,
      String imageUrl) async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      setState(() {
        downloading(context, url, filename, imageUrl);
      });
    } else {
      setState(() {
        downloading(context, url, filename, imageUrl);
      });
    }
  }

  downloading(BuildContext context, String fileUrl, String filename,
      String imageUrl) async {
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
        ipath: imagepath,
        iurl: imageUrl,
      ),
    )/* .then((value) => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => DownloadAlert(
            url: imageUrl,
            path: imagepath,
          ),
        ) */
        .then((v) async {
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

        if (await epubfile.exists()) {
          if (await imagefile.exists()) {
            
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

            
              setState(() {
                _downloaded = downloaded.yes;
              downloadPath = filepath;
              });
              

            
          }
        }

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
    });
  }

  static const pageChannel = const EventChannel('com.xiaofwang.epub_kitty/page');

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final String name = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xff6e9bdf),
      /* appBar: AppBar(
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
      ), */
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Book Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                  /* IconButton(
                            icon: Icon(Icons.search, color: Colors.white),
                            onPressed: null), */
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection("Books")
                  .where("Name", isEqualTo: name)
                  .snapshots(),
              builder: (
                BuildContext context,
                AsyncSnapshot snapshot,
              ) {
                return snapshot.hasData
                    ? Container(
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
                                  color: Colors.grey[100],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, right: 0, top: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Hero(
                                                tag: 'BookCover0',
                                                child: Container(
                                                  height: 300,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      snapshot.data.documents[0]
                                                          ['Image'],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 0, right: 0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    100 -
                                                                110,
                                                            child: Text(
                                                              snapshot.data
                                                                      .documents[
                                                                  0]['Name'],
                                                              /* .toUpperCase(), */
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color: Color(
                                                                  0xff6e9bdf),
                                                            ),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.bookmark,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        snapshot.data
                                                                .documents[0]
                                                            ['Author'],
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: double.infinity,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: snapshot
                                                              .data
                                                              .documents[0]
                                                                  ['Category']
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 10,
                                                                      right:
                                                                          10),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x996e9bdf),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          snapshot
                                                                              .data
                                                                              .documents[0]['Category'][index],
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
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
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'Desription',
                                                  style: TextStyle(
                                                    color: Color(0xff6e9bdf),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      snapshot.data.documents[0]
                                                          ['Description'],
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Expanded(
                                                    flex: 0,
                                                    child: Container()),
                                                Center(
                                                  child: downloadPath != null
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                                String path =
                                                                    downloadPath;
                                                                /* checkDownload(snapshot
                                                              .data
                                                              .documents[0]
                                                                  ['Name']
                                                              .replaceAll(
                                                                  " ", "_")
                                                              .replaceAll(
                                                                  r"\'", "")); */
                                                                EpubKitty.setConfig(
                                                                    "androidBook",
                                                                    "#6e9bdf",
                                                                    "vertical",
                                                                    true);
                                                                EpubKitty.open(
                                                                    path); 

                                                                    /* pageChannel.receiveBroadcastStream().listen((Object event) {
                                        print('page:$event');
                                      }, onError: null); */

                                                              },);
                                                          },
                                                          child: Container(
                                                            width: 200,
                                                            height: 45,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xff6e9bdf),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                              'Read Book',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                            ),
                                                          ),
                                                        )
                                                      :

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

                                                      GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              startDownload(
                                                                context,
                                                                snapshot.data
                                                                        .documents[
                                                                    0]['file'],
                                                                snapshot
                                                                    .data
                                                                    .documents[
                                                                        0]
                                                                        ['Name']
                                                                    .replaceAll(
                                                                        " ",
                                                                        "_")
                                                                    .replaceAll(
                                                                        r"\'",
                                                                        ""),
                                                                snapshot.data
                                                                        .documents[
                                                                    0]['Image'],
                                                              );
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 200,
                                                            height: 45,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xff6e9bdf),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                              'Add to Library',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: const SpinKitChasingDots(
                          color: Color(0xff6e9bdf),
                          size: 100,
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}

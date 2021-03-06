import 'dart:io';
import 'package:epub_kitty/epub_kitty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Database/Downloads_Database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Downloads extends KFDrawerContent {
  @override
  _DownloadsState createState() => _DownloadsState();
}

double percent = 30;

class _DownloadsState extends State<Downloads> {
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

  int currentIndex;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getDownloads();
    currentIndex = 1;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff6e9bdf),
      /* appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {}),
        centerTitle: true,
        title: Text(
          'Downloads',
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
      body: dls.isEmpty
          ? SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 20, left: 30, right: 10, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                iconSize: 30.0,
                                onPressed: widget.onMenuPressed),
                            Text(
                              'Downloads',
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
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/noDownloads.jpg",
                                  height: 450,
                                  width: 450,
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          )))
                ],
              ),
            )
          : SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 20, left: 30, right: 10, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                iconSize: 30.0,
                                onPressed: widget.onMenuPressed),
                            Text(
                              'Downloads',
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
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: GridView.builder(
                          itemCount: dls.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: .55,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            Map dl = dls[index];
                            return new GestureDetector(
                              onLongPress: () {
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: "Delete Book",
                                  desc:
                                      "Do you really want to delete '${dl['name']}'"
                                          .replaceAll("_", " ")
                                          .replaceAll(r"\'", ""),
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      color: Colors.grey[300],
                                    ),
                                    DialogButton(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        db.remove({"id": dl['id']}).then(
                                            (v) async {
                                          File f = File(dl['path']);
                                          File image = File(dl['image']);
                                          if (await f.exists()) {
                                            f.delete();
                                          }
                                          if (await image.exists()) {
                                            image.delete();
                                          }
                                          setState(() {
                                            dls.removeAt(index);
                                          });
                                          print("done");
                                          Navigator.pop(context);
                                        });
                                      },
                                      color: Color(0xff6e9bdf),
                                    )
                                  ],
                                ).show();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    /* height: 350, */
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          File(
                                            dl['image'],
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                        /* Image.asset(
                              dl['image'],
                              fit: BoxFit.cover,
                            ), */
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      dl['name']
                                          .replaceAll("_", " ")
                                          .replaceAll(r"\'", ""),
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  /* Text(dl['author']), */
                                ],
                              ),
                              onTap: () {
                                EpubKitty.setConfig(
                                    "iosBook", "#6e9bdf", "vertical", true);
                                EpubKitty.open(dl['path']);
                                /* showDialog(
                barrierDismissible: false,
                context: context,
                child: new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("GridView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  content: new Text("Selected Item $index"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ),
              ); */
                              },
                            );
                          }),
                    ),
                  )),
                ],
              ),
            ),
      /* bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 10,
        hasNotch: true,
        hasInk: true,
        onTap: changePage,
        //inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem> [
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.dashboard, color: Colors.black,), activeIcon: Icon(Icons.home, color: Color(0xff6e9bdf),), title: Text("Home")),
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.local_library, color: Colors.black,), activeIcon: Icon(Icons.local_library, color: Color(0xff6e9bdf),), title: Text("Library")),
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.settings, color: Colors.black,), activeIcon: Icon(Icons.settings, color: Color(0xff6e9bdf),), title: Text("Settings")),
        ],
      ), */
    );
    ;
  }
}

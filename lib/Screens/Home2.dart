import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Providers/search_Provider.dart';
import 'package:prearticle/Screens/Book_Details.dart';
import 'package:prearticle/Widgets/Book_Series_Widget.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:prearticle/Widgets/Card_Swipe.dart';
import 'package:getflutter/getflutter.dart';



class HomePage extends StatefulWidget {
  HomePage({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }


  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int index = 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffe7f0ff),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: SizeConfig.blockSizeHorizontal * 100 - 40,
                    child: TextField(
                      onChanged: (val) {
                        initiateSearch(val);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Here',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 0,
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  primary: false,
                  shrinkWrap: true,
                  children: tempSearchStore.map((element) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) => BookDetails(),
                              settings:
                                  RouteSettings(arguments: element['Name'])),
                        );
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 2.0,
                          child: Container(
                              child: Center(
                                  child: Text(
                            element['Name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          )))),
                    );
                  }).toList()),
              ),
                  ),
                  
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
                padding: EdgeInsets.only(left: 0, right: 0, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Book Series',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Container(
                        height: 150,
                        child: BookSeriesWidget(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15, left: 20),
                      child: Text(
                        'Recently Added',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(child: CardSwipe())
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      /* bottomNavigationBar: BubbleBottomBar(
            opacity: .2,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            elevation: 10,
            hasNotch: true,
            hasInk: true,
            currentIndex: currentIndex,
            onTap: changePage,
        //inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem> [
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.dashboard, color: Colors.black,), activeIcon: Icon(Icons.home, color: Color(0xff6e9bdf),), title: Text("Home")),
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.local_library, color: Colors.black,), activeIcon: Icon(Icons.local_library, color: Color(0xff6e9bdf),), title: Text("Library")),
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.settings, color: Colors.black,), activeIcon: Icon(Icons.settings, color: Color(0xff6e9bdf),), title: Text("Settings")),
        ],
      ), */
    );
  }
}

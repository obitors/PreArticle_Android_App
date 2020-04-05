import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/UI%20Screens/del_for_card.dart';
import 'package:prearticle/Widgets/Book_Series_Widget.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
            flex: 1,
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left:0, right: 0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left:20),
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
                        padding: EdgeInsets.only(top:20,),
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
                      Expanded(child: MoviesConceptPage())
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: 0,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 10,
        hasNotch: true,
        hasInk: true,
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem> [
            BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.dashboard, color: Colors.black,), activeIcon: Icon(Icons.home, color: Color(0xff6e9bdf),), title: Text("Home")),
            BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.local_library, color: Colors.black,), activeIcon: Icon(Icons.local_library, color: Color(0xff6e9bdf),), title: Text("Library")),
            BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.settings, color: Colors.black,), activeIcon: Icon(Icons.settings, color: Color(0xff6e9bdf),), title: Text("Settings")),
        ],
      ),
    );
  }
}

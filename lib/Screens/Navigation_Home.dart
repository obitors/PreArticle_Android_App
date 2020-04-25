import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:prearticle/Screens/Downloads.dart';
import 'package:prearticle/Screens/Home.dart';
/* import 'package:prearticle/Screens/Website.dart'; */

class NavigationHome extends StatefulWidget {
  NavigationHome({Key key, Null Function() onPressed}) : super(key: key);

  @override
  
  _NavigationHomeState createState() => _NavigationHomeState();
}


class _NavigationHomeState extends State<NavigationHome> {

  int currentindex = 0;

  void changePage(int index) {
    setState(() {
      currentindex = index;
    });
  }

  final List<Widget> _children = [
    HomePage(onPressed: () {  },),
    Downloads(),
    //PreArticleWebsite(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[currentindex],
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 10,
        hasNotch: true,
        hasInk: true,
        currentIndex: currentindex,
        onTap: changePage,
        //inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem> [
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.dashboard, color: Colors.black,), activeIcon: Icon(Icons.home, color: Color(0xff6e9bdf),), title: Text("Home")),
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.local_library, color: Colors.black,), activeIcon: Icon(Icons.local_library, color: Color(0xff6e9bdf),), title: Text("Library")),
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.settings, color: Colors.black,), activeIcon: Icon(Icons.settings, color: Color(0xff6e9bdf),), title: Text("Settings")),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Widgets/Book_Series_Widget.dart';

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
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left:20, right: 20, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Book Series',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      Container(
                        height: 70,
                        child: BookSeriesWidget(),
                      ),
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            backgroundColor: Color(0xff6e9bdf),
            title: Text('Library')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Color(0xff6e9bdf),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            backgroundColor: Color(0xff6e9bdf),
            title: Text('Settings')
          )
        ],
      ),
    );
  }
}

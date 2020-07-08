import 'dart:io';
import 'package:epub_kitty/epub_kitty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Credits extends KFDrawerContent {
  @override
  _CreditsState createState() => _CreditsState();
}

double percent = 30;

class _CreditsState extends State<Credits> {
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
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(bottom: 20, left: 30, right: 10, top: 20),
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
                          'Credits',
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
                    width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white,
                ),
                child: Padding(padding: EdgeInsets.only(top:25,left:20, right:20, bottom:20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Text(
                      'UI Design: obitors \nApp Development: obitors \nIcons: Fontawesome \nAvatar API: Gravatar \nSDK: Flutter \nLanguage Translation: flutter_localizations \nWeb Support: webview_flutter',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Made with ',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    FaIcon(
                      FontAwesomeIcons.solidHeart,
                      size: 15,
                      color: Colors.grey[500],
                    ),
                    Text(
                      ' By @obitors',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
                  ],
                )
                )
              ))
            ],
          ),
        )
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

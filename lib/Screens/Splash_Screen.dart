import 'dart:async';
import 'package:prearticle/Screens/Login_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/notifier/Firebase_Auth_Notifier.dart';
import 'package:provider/provider.dart';

class splash extends StatefulWidget {
  splash({Key key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }
  var logo;
  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(
          builder: (context) => loginPage(), 
        ),);
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            height: SizeConfig.blockSizeHorizontal * 90,
            width: SizeConfig.blockSizeHorizontal * 37,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: widget.hashCode,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 37,
                        height: SizeConfig.blockSizeHorizontal * 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Pre ',
                                  style: TextStyle(
                                    fontSize:
                                    SizeConfig.safeBlockHorizontal * 7,
                                    color: Color(0xff6e9bdf),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Article',
                                  style: TextStyle(
                                    fontSize:
                                    SizeConfig.safeBlockHorizontal * 7,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'Book Store',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                                letterSpacing: 3.6,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Made with ',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    FaIcon(
                      FontAwesomeIcons.coffee,
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
            ),
          ),
        ),
      ),
    );
  }
}
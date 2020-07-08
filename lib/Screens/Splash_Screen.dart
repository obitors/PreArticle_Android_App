import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Models/user.dart';
import 'package:prearticle/Screens/Anime.dart';
import 'package:prearticle/Screens/Login_Page.dart';
import 'package:prearticle/Screens/Navigation_Home.dart';
import 'package:prearticle/Screens/SignUp_page.dart';
import 'package:prearticle/Screens/login/signup.dart';
import 'package:prearticle/libm/mainwidget.dart';
import 'package:prearticle/notifier/Firebase_Auth_Notifier.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {


/*   Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }
  var logo;
  UserModel _user = Provider.of<UserModel>(context);
  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(
          builder: (context) => Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          
          return (_user != null) ? NavigationHome() :SignUpScreenPage();
        },
      ),
        ),);
  } */

  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  @override
  
  void initState() {
    /* loadData(); */
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel _user = Provider.of<UserModel>(context);
    Timer(
            Duration(seconds: 2),
                () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => (_user != null) ? MainWidget() :SignUpScreenPage())));
  
    SizeConfig().init(context);
    final color = Color(0xff6e9bdf);
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: <Widget>[
                DelayedAnimation(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: SizeConfig.blockSizeVertical * 60,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 13.7),
                          ),
                          Hero(
                            tag: widget.hashCode,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 37,
                                  height: SizeConfig.blockSizeHorizontal * 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/logo.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
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
                                    ),
                                  ],
                                ),
                                Text(
                                  'Book Store',
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5.5,
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
                  ),
                  delay: delayedAmount + 500,
                ),
                /* DelayedAnimation (
                  child: Text(
                    "Hi There",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 1000,
                ),
                DelayedAnimation(
                  child: Text(
                    "I'm Reflectly",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 2000,
                ), */
                SizedBox(
                  height: 30.0,
                ),
                /* DelayedAnimation(
                  child: Text(
                    "A Free E-Book",
                    style: TextStyle(fontSize: 20.0, color: color),
                  ),
                  delay: delayedAmount + 1000,
                ),
                DelayedAnimation(
                  child: Text(
                    "And Articles Reader",
                    style: TextStyle(fontSize: 20.0, color: color),
                  ),
                  delay: delayedAmount + 1000,
                ), */
                DelayedAnimation(child: Row(
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
                delay: delayedAmount + 1000,
                ),
                SizedBox(
                  height: 100.0,
                ),
                /* DelayedAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => SignUpPage(
                                  onPressed: () {},
                                )),
                      );
                    },
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                  delay: delayedAmount + 2000,
                ), */
                SizedBox(
                  height: 50.0,
                ),
                /* DelayedAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => loginPage(
                                  onPressed: () {},
                                )),
                      );
                    },
                    child: Text(
                      "I Already have An Account".toUpperCase(),
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: color),
                    ),
                  ),
                  delay: delayedAmount + 3000,
                ), */
              ],
            ),
          )
          //  Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
          //     SizedBox(
          //       height: 20.0,
          //     ),
          //      Center(

          //   ),
          //   ],

          // ),
          ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color(0xff6e9bdf),
        ),
        child: Center(
          child: Text(
            'Join PreArticle',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
}

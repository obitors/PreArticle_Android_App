import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prearticle/Screens/Splash_Screen.dart';


void main() => runApp(
    PreArticle()
);

class PreArticle extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PreArticle Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff6E9BDF),
      ),
      home: splash(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:prearticle/UI%20Screens/Splash_Screen.dart';
import 'UI Screens/SplashScreen.dart';

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
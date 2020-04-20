import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prearticle/Screens/Downloads.dart';
import 'package:prearticle/Screens/Splash_Screen.dart';
import 'package:prearticle/notifier/Firebase_Auth_Notifier.dart';
import 'package:provider/provider.dart';
import '';


void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => AuthNotifier(), create: (BuildContext context) {  },
        ),
      ],
      child: PreArticle(),
    ));

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
      home: Downloads(),
    );
  }
}
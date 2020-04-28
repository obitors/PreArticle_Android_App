import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prearticle/Screens/AnimeTest.dart';
import 'package:prearticle/Screens/Downloads.dart';
import 'package:prearticle/Screens/Home.dart';
import 'package:prearticle/Screens/Login_Page.dart';
import 'package:prearticle/Screens/Search_Bar.dart';
import 'package:prearticle/Screens/Splash_Screen.dart';
import 'package:prearticle/Screens/Website.dart';
import 'package:prearticle/notifier/Firebase_Auth_Notifier.dart';

import 'package:provider/provider.dart';
import 'Providers/Details_Provider.dart';


void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
        ChangeNotifierProvider(
          builder: (context) => AuthNotifier()),
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
      home: splash()
    );
  }
}
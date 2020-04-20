import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Database/Downloads_Database.dart';
import 'package:prearticle/Widgets/HundredWays.dart';

class Downloads extends StatefulWidget {
  Downloads({Key key}) : super(key: key);

  @override
  _DownloadsState createState() => _DownloadsState();
}

double percent = 30;

class _DownloadsState extends State<Downloads> {

  bool done = true;
  var db = DownloadsDB();
  /* static final uuid = Uuid(); */

  List dls = List();
  getDownloads() async{
    List l = await db.listAll();
    setState(() {
      dls.addAll(l);
    });
  }

  @override
  void initState() {
    super.initState();
    getDownloads();
  }



  @override
  
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff6e9bdf),
      appBar: AppBar(
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
      ),
      body: dls.isEmpty
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 300,
              width: 300,
            ),

            Text(
              "Nothing is here",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )
      : Text('Kucch to hai')
    );
  }
}
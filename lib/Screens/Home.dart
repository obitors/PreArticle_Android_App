import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override


  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.white, child: Text('Hello')),
      ),
    );
  }
}
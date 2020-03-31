import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
  loginPage({@required this.onPressed});
  final GestureTapCallback onPressed;
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.7,
              ),
              Positioned(
                top: 200,
                left: (MediaQuery.of(context).size.width / 2) - 125,
                child: Hero(
                  tag: widget.hashCode,
                  child: Container(
                    width: 250,
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffe7f0ff),
                    )),
              ),
              Positioned(
                top: 300,
                left: -10,
                child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Color(0xffc6d2e3), Color(0xff6e9bdf)]))),
              ),
            ],
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width -125,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.grey[300],
                width: 2,
              ),
              color: Colors.transparent,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width -125,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.grey[300],
                width: 2,
              ),
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

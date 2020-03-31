import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prearticle/Configuration/app_config.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
  loginPage({@required this.onPressed});
  final GestureTapCallback onPressed;
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: SizeConfig.blockSizeVertical * 47,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Hero(
                    tag: widget.hashCode,
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 26.7,
                      height: SizeConfig.blockSizeHorizontal * 36.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'Pre ',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 7,
                          color: Color(0xff6e9bdf),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Article',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 7,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
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
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                    width: SizeConfig.blockSizeHorizontal * 40,
                    height: SizeConfig.blockSizeHorizontal * 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffe7f0ff),
                    )),
              ),
              Positioned(
                top: 300,
                left: -10,
                child: Container(
                    width: SizeConfig.blockSizeHorizontal * 12.5,
                    height: SizeConfig.blockSizeHorizontal * 12.5,
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
            width: MediaQuery.of(context).size.width - 125,
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
            width: MediaQuery.of(context).size.width - 125,
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

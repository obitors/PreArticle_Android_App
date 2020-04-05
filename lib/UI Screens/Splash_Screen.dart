import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prearticle/Configuration/app_config.dart';

class splash extends StatefulWidget {
  splash({Key key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            height: SizeConfig.blockSizeHorizontal *  80,
            width: SizeConfig.blockSizeHorizontal *  37,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: SizeConfig.blockSizeHorizontal *  37,
                  decoration: BoxDecoration(
                    color: Color(0xff6e9bdf),
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Center(
                    child: Container(
                      height: SizeConfig.blockSizeHorizontal *  11.2,
                      width: SizeConfig.blockSizeHorizontal *  11.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.blockSizeHorizontal *  12,
                  width: SizeConfig.blockSizeHorizontal * 12,
                  decoration: BoxDecoration(
                      color: Color(0xff6e9bdf),
                      borderRadius: BorderRadius.circular(50)),
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
                          Text('Pre ',
                          style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 7,
                          color: Color(0xff6e9bdf),
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                          Text('Article',
                          style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 7,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                        )
                        ],
                      ),
                      Text('Book Store',
                      style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                      letterSpacing: 3.6,
                      color: Colors.grey[500],
                    ),
                    )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

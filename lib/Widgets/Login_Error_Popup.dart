import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginAlert extends StatefulWidget {
/*   final String someerror;


  LoginAlert(
      {Key key,
      @required this.someerror,
      })
      : super(key: key); */

  @override
  _LoginAlertState createState() => _LoginAlertState();
}

enum cancel { enable, disable }

class _LoginAlertState extends State<LoginAlert> {



  @override
  void initState() {
    super.initState();

  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Container(
          child: Center(
            child: Padding(
            padding:
                EdgeInsets.only(left: 20, right: 20,),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () async {
                            setState(() {
                              
                            }
                            );
                            /* await epubfile.exists()? await epubfile.delete():
                            await imagefile.exists()? await imagefile.delete(): */
                            Navigator.pop(context);
                          },
                        ),
                            )),
                        const SpinKitChasingDots(
                          color: Color(0xff6e9bdf),
                          size: 100,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Downloading",
                          style: TextStyle(
                            color: Color(0xff6e9bdf),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    
                    SizedBox(
                      height: 5,
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}

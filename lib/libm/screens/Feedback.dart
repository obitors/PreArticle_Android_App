import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epub_kitty/epub_kitty.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Models/user.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Feedback extends KFDrawerContent {
  @override
  _FeedbackState createState() => _FeedbackState();
}

double percent = 30;

class _FeedbackState extends State<Feedback> {
  String _uid = '';
  String _name = '';
  String _email = '';
  String _admin = '';

  TextEditingController feedback = new TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    final UserModel user = Provider.of<UserModel>(context);
    if (user != null) {
      setState(() {
        _uid = user.uid;
        _name = user.name;
        _email = user.email;
      });
    }

    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Color(0xff6e9bdf),
        /* appBar: AppBar(
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
      ), */
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(bottom: 20, left: 30, right: 10, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            iconSize: 30.0,
                            onPressed: widget.onMenuPressed),
                        Text(
                          'Feedback',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    /* IconButton(
                            icon: Icon(Icons.search, color: Colors.white),
                            onPressed: null), */
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: SingleChildScrollView(
                          
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/Feedback.jpg",
                              height: 450,
                              width: 450,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 15,
                                  right: SizeConfig.blockSizeHorizontal * 15,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    /* prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                      child: Icon(
                                        Icons.feedback,
                                      ),
                                    ), */

                                    hintText: 'Write Feedback',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                  ),
                                  autofocus: false,
                                  controller: feedback,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  textInputAction: TextInputAction.newline,
                                  onChanged: (value) => null,
                                  /* onSaved: (value) => _email.text = value, */
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Firestore.instance.runTransaction(
                                      (Transaction transactionHandler) {
                                    return Firestore.instance
                                        .collection('Feedback')
                                        .document()
                                        .setData({
                                      "E-mail": _email,
                                      "Name": _name,
                                      "Message": feedback.text,
                                    });
                                  });
                                  Flushbar(
                                    title: 'Feedback Submitted',
                                    message:
                                        "Thank you for your feedback",
                                    duration: Duration(seconds: 2),
                                  )..show(context);
                                });
                              },
                              child: Container(
                                width: 200,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xff6e9bdf),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        ),
                      )))
            ],
          ),
        )
        /* bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 10,
        hasNotch: true,
        hasInk: true,
        onTap: changePage,
        //inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem> [
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.dashboard, color: Colors.black,), activeIcon: Icon(Icons.home, color: Color(0xff6e9bdf),), title: Text("Home")),
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.local_library, color: Colors.black,), activeIcon: Icon(Icons.local_library, color: Color(0xff6e9bdf),), title: Text("Library")),
          BubbleBottomBarItem(backgroundColor: Color(0xff6e9bdf), icon: Icon(Icons.settings, color: Colors.black,), activeIcon: Icon(Icons.settings, color: Color(0xff6e9bdf),), title: Text("Settings")),
        ],
      ), */
        );
    ;
  }
}

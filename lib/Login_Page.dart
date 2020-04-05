import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prearticle/Chapters/Contents_List.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/UI%20Screens/Home_Screen.dart';

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
      resizeToAvoidBottomInset: false,
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
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 13.7),
                  ),
                  Hero(
                    tag: widget.hashCode,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 26.7,
                          height: SizeConfig.blockSizeHorizontal * 36.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.fill,
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
                  ),
                ),
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
                        colors: [Color(0xffc6d2e3), Color(0xff6e9bdf)]),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 4.3,
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 5.3,
                width: SizeConfig.blockSizeHorizontal * 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey[200],
                    width: 2,
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'Email address',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.7,
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 5.3,
                width: SizeConfig.blockSizeHorizontal * 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey[200],
                    width: 2,
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                          obscureText: true,
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 4.3,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()),
                  );
                },
                child: Container(
                  height: SizeConfig.blockSizeHorizontal * 15,
                  width: SizeConfig.blockSizeHorizontal * 15,
                  decoration: BoxDecoration(
                      color: Color(0xff6e9bdf),
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 10,
              ),
              Container(
                child: Text('Forgot Password'),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.7,
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Don\'t have an account: ',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Container(
                        child: Text('SignUp?'),
                      ),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

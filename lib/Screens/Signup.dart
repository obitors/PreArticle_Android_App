import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Screens/Home.dart';
import 'package:prearticle/Screens/Navigation_Home.dart';
import 'package:prearticle/Screens/SignUp_page.dart';
import 'package:prearticle/Widgets/Login_Error_Popup.dart';
import 'package:prearticle/api/user_api.dart';
import 'package:prearticle/notifier/Firebase_Auth_Notifier.dart';
import 'package:prearticle/objects/Auth_User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
  loginPage({@required this.onPressed});
  final GestureTapCallback onPressed;
}

enum AuthMode { Login, Signup }

class _loginPageState extends State<loginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  User _user = User();

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm()  {
    if (!_formKey.currentState.validate()) {
      return;
    }

    var error;
    _formKey.currentState.save();

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    if (_authMode == AuthMode.Login) {
      error =  login(_user, authNotifier);
    } else {
      signup(_user, authNotifier);
    }


    Future.delayed(const Duration(milliseconds: 1000), () {

// Here you can write your code

  if (error != null) {
      var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: true,
        isOverlayTapDismiss: true,
        descStyle: TextStyle(color: Colors.grey[800]),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        
        titleStyle: TextStyle(
          color: Color(0xff6e9bdf),
        ),
      );

      setState(() {
        Alert (

        context: context,
        image: Image.asset("assets/images/loginerror.png"),
        style: alertStyle,
        title: "Login Error",
        desc: 'Please check your credentials or internet cnnection',
        content: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            GestureDetector(
              onTap: ()  => Navigator.pop(context),
              child: Container(
              height: 45,
              width: double.infinity/1.5,
              decoration: BoxDecoration(
                color: Color(0xff6e9bdf),
                borderRadius: BorderRadius.circular(25)
              ),
              child: Center(
                child: Text('Close',
                style: TextStyle(
                  color: Colors.white,
                ),
                ),
              ),
            ),
            )
          ],
        ),
        buttons: [
          
        ]
      ).show();
      });
    }

});
    
  }

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

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
          _authMode == AuthMode.Login
              ? Expanded(
                  flex: 1,
                  child: _login(),
                )
              : Expanded(
                  flex: 1,
                  child: _signup(),
                ),
          Column(
            children: <Widget>[
              /* Container(
                child: Text(
                  'SignIn With Google',
                  style: TextStyle(
                    color: Color(0xff6e9bdf),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ), */
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.7,
              ),
              Container(
                child: Text('Forgot Password'),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.7,
              ),
              Container(
                  child: GestureDetector(
                onTap: () {
                  setState(() {
                    _authMode = _authMode == AuthMode.Login
                        ? AuthMode.Signup
                        : AuthMode.Login;
                  }
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: _authMode == AuthMode.Login
                            ? Text(
                                'Don\'t have an account: ',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              )
                            : Text(
                                'Already have an account ',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              )),
                    Container(
                      child: _authMode == AuthMode.Login
                          ? Text('SignUp?')
                          : Text('Login?'),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }

  _alert() {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Delete Book",
      desc: "Please Check your credentials",
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.grey[600], fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.grey[300],
        ),
      ],
    ).show();
  }

  Widget _login() {
    return Column(
      children: <Widget>[
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
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4.3,
        ),
        Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _dismissKeyboard(context);
                  },
                  child: Container(
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                hintText: 'Email address',
                                border: InputBorder.none,
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Email is required';
                                }

                                if (!RegExp(
                                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }

                                return null;
                              },
                              onSaved: (String value) {
                                _user.email = value;
                              },
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1.7,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _dismissKeyboard(context);
                  },
                  child: Container(
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                hintText: 'Password',
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Password is required';
                                }

                                if (value.length < 5 || value.length > 20) {
                                  return 'Password must be betweem 5 and 20 characters';
                                }

                                return null;
                              },
                              onSaved: (String value) {
                                _user.password = value;
                              },
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            )),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4.3,
        ),
        GestureDetector(
          onTap: () => _submitForm(),
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
        /* SizedBox(
          height: SizeConfig.blockSizeVertical * 7,
        ), */
      ],
    );
  }

  Widget _signup() {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            'SignUp',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10,
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4.3,
        ),
        Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _dismissKeyboard(context);
                  },
                  child: Container(
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.person),
                                hintText: 'Username',
                                border: InputBorder.none,
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Display Name is required';
                                }

                                if (value.length < 5 || value.length > 12) {
                                  return 'Display Name must be betweem 5 and 12 characters';
                                }

                                return null;
                              },
                              onSaved: (String value) {
                                _user.username = value;
                              },
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1.7,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _dismissKeyboard(context);
                  },
                  child: Container(
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                hintText: 'Email address',
                                border: InputBorder.none,
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Email is required';
                                }

                                if (!RegExp(
                                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }

                                return null;
                              },
                              onSaved: (String value) {
                                _user.email = value;
                              },
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1.7,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _dismissKeyboard(context);
                  },
                  child: Container(
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                hintText: 'Password',
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Password is required';
                                }

                                if (value.length < 5 || value.length > 20) {
                                  return 'Password must be betweem 5 and 20 characters';
                                }

                                return null;
                              },
                              onSaved: (String value) {
                                _user.password = value;
                              },
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            )),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4.3,
        ),
        GestureDetector(
          onTap: () => _submitForm(),
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
        /* SizedBox(
          height: SizeConfig.blockSizeVertical * 7,
        ), */
      ],
    );
  }
}

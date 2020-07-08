import 'package:flutter/material.dart';
import 'package:prearticle/Screens/login/forgotPassword.dart';
import 'package:prearticle/Screens/login/login.dart';
import 'package:prearticle/Screens/login/signup.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiating this object
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String resetPassword = '/reset-password';
  static const String updateProfile = '/update-profile';

  static final routes = <String, WidgetBuilder>{
    signin: (BuildContext context) => LoginScreenPage(),
    signup: (BuildContext context) => SignUpScreenPage(),
/*     settings: (BuildContext context) => SettingsUI(), */
    resetPassword: (BuildContext context) => ResetPasswordScreen(),
/*     updateProfile: (BuildContext context) => UpdateProfileUI(), */
  };
}

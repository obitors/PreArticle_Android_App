import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prearticle/Models/user.dart';
/* import 'package:prearticle/Screens/AnimeTest.dart'; */
import 'package:prearticle/Screens/Splash_Screen.dart';
import 'package:prearticle/constants/routes.dart';
import 'package:prearticle/firestore/db_firestore.dart';
import 'package:prearticle/libm/utils/class_builder.dart';
import 'package:prearticle/notifier/Firebase_Auth_Notifier.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:prearticle/services/auth.dart';
import 'package:prearticle/services/language.dart';
import 'package:provider/provider.dart';
import 'Providers/Details_Provider.dart';
import 'package:prearticle/localizations.dart';

class PreArticle extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserModel _user = Provider.of<UserModel>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final navigatorKey = GlobalKey<NavigatorState>();
    return Consumer<LanguageProvider>(
      builder: (_, languageProviderRef, __) {
        return AuthWidgetBuilder(
          builder:
              (BuildContext context, AsyncSnapshot<FirebaseUser> userSnapshot) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: 'PreArticle Application',
              //begin language translation stuff
              //https://github.com/aloisdeniel/flutter_sheet_localization
              //https://github.com/aloisdeniel/flutter_sheet_localization/tree/master/flutter_sheet_localization_generator/example
              locale: languageProviderRef.getLocale, // <- Current locale
              localizationsDelegates: [
                const AppLocalizationsDelegate(), // <- Your custom delegate
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.languages.keys
                  .toList(), // <- Supported locales
              //end language translation stuff
              // Firebase Analytics - not working with web
              /*navigatorObservers: [
                    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
                  ],*/
              debugShowCheckedModeBanner: false,
              //title: labels.app.title,
              routes: Routes.routes,
              theme: ThemeData(
                primaryColor: Color(0xff6e9bdf),
              ),
              home: Scaffold(
                  body: DoubleBackToCloseApp(
                child: IntroScreen(),
                snackBar: const SnackBar(
                  content: Text('Tap back again to leave'),
                ),
              )),
            );
          },
        );
      },
    );
  }
}
/* 
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel _user = Provider.of<UserModel>(context);
    //final labels = AppLocalizations.of(context);
    // js.context.callMethod("alert", <String>["Your debug message"]);
    return Consumer<LanguageProvider>(
      builder: (_, languageProviderRef, __) {
        return Consumer<ThemeProvider>(
          builder: (_, themeProviderRef, __) {
            //{context, data, child}
            return AuthWidgetBuilder(
              builder: (BuildContext context,
                  AsyncSnapshot<FirebaseUser> userSnapshot) {
                return MaterialApp(
                  //begin language translation stuff
                  //https://github.com/aloisdeniel/flutter_sheet_localization
                  //https://github.com/aloisdeniel/flutter_sheet_localization/tree/master/flutter_sheet_localization_generator/example
                  locale: languageProviderRef.getLocale, // <- Current locale
                  localizationsDelegates: [
                    const AppLocalizationsDelegate(), // <- Your custom delegate
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.languages.keys
                      .toList(), // <- Supported locales
                  //end language translation stuff
                  // Firebase Analytics - not working with web
                  /*navigatorObservers: [
                    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
                  ],*/
                  debugShowCheckedModeBanner: false,
                  //title: labels.app.title,
                  routes: Routes.routes,
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.darkTheme,
                  themeMode: themeProviderRef.isDarkModeOn
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  home: (_user != null) ? HomeUI() : SignInUI(),
                );
              },
            );
          },
        );
      },
    );
  }
} */

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ClassBuilder.registerClasses();
  LanguageProvider().setInitialLocalLanguage();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DetailsProvider()),
      ChangeNotifierProvider(builder: (context) => AuthNotifier()),
      StreamProvider<UserModel>.value(
          value: UserData<UserModel>(collection: 'users').documentStream),
      //StreamProvider<FirebaseUser>.value(value: AuthService().user),
      ChangeNotifierProvider<LanguageProvider>(
        create: (context) => LanguageProvider(),
      ),
      ChangeNotifierProvider<AuthService>(
        create: (context) => AuthService(),
      ),
    ],
    child: PreArticle(),
  ));
}

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<FirebaseUser>) builder;

  @override
  Widget build(BuildContext context) {
    //final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<FirebaseUser>(
      stream: AuthService().user,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        final FirebaseUser user = snapshot.data;
        if (user != null) {
          /*
          * For any other Provider services that rely on user data can be
          * added to the following MultiProvider list.
          * Once a user has been detected, a re-build will be initiated.
           */
          return MultiProvider(
            providers: [
              Provider<FirebaseUser>.value(value: user),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}

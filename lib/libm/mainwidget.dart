import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Models/user.dart';
import 'package:provider/provider.dart';
import 'package:prearticle/services/auth.dart';
import 'screens/Home_Page.dart';
import 'screens/Downloads.dart';
import 'screens/Website.dart';
import 'screens/Feedback.dart';
import 'screens/Credits.dart';
import 'utils/class_builder.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  KFDrawerController _drawerController;

  bool _loading = true;
  String _uid = '';
  String _name = '';
  String _email = '';
  String _admin = '';
  String _photoUrl = '';

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: HomePage(),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Home',
              style: TextStyle(
                  color: Color(0xff6b7885),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          icon: FaIcon(
            FontAwesomeIcons.home,
            size: 25,
            color: Color(0xff6b7885),
          ),
          page: HomePage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Downloads',
              style: TextStyle(
                  color: Color(0xff6b7885),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          icon: FaIcon(
            FontAwesomeIcons.download,
            size: 25,
            color: Color(0xff6b7885),
          ),
          page: Downloads(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Website',
              style: TextStyle(
                  color: Color(0xff6b7885),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          icon: FaIcon(
            FontAwesomeIcons.globe,
            size: 25,
            color: Color(0xff6b7885),
          ),
          page: PreArticleWebsite(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Feedback',
              style: TextStyle(
                  color: Color(0xff6b7885),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          icon: FaIcon(
            FontAwesomeIcons.solidCommentDots,
            size: 25,
            color: Color(0xff6b7885),
          ),
          page: ClassBuilder.fromString('Feedback'),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Credits',
              style: TextStyle(
                  color: Color(0xff6b7885),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          icon: FaIcon(
            FontAwesomeIcons.solidCopy,
            size: 25,
            color: Color(0xff6b7885),
          ),
          page: ClassBuilder.fromString('Credits'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final UserModel user = Provider.of<UserModel>(context);
    if (user != null) {
      setState(() {
        _loading = false;
        _uid = user.uid;
        _name = user.name;
        _email = user.email;
        _photoUrl = user.photoUrl;
      });
    }

    return Scaffold(
      body: KFDrawer(
        borderRadius: 20,
        shadowBorderRadius: 0.0,
        menuPadding: EdgeInsets.all(0.0),
//        scrollable: true,
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Stack(
            children: <Widget>[
              Container(
                height: SizeConfig.blockSizeVertical * 35,
              ),
              Positioned(
                  top: -SizeConfig.blockSizeVertical * 2,
                  left: -SizeConfig.blockSizeVertical * 5,
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 27,
                    width: SizeConfig.blockSizeVertical * 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeVertical * 27),
                      color: Color(0xff303742),
                    ),
                  )),
              Positioned(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  top: SizeConfig.blockSizeVertical * 12,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: SizeConfig.blockSizeVertical * 15,
                          width: SizeConfig.blockSizeVertical * 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockSizeVertical * 15),
                              border: Border.all(
                                  width: 3, color: Color(0xff6b7885))),
                          child: ClipOval(
                            child: Image.network(
                              user?.photoUrl,
                              fit: BoxFit.cover,
                            ),
                          )),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Text(
                        _name,
                        style: TextStyle(
                          color: Color(0xff6b7885),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
        footer: KFDrawerItem(
          text: Text('Logout',
              style: TextStyle(
                  color: Color(0xff6b7885),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          icon: FaIcon(
            FontAwesomeIcons.signOutAlt,
            size: 25,
            color: Color(0xff6b7885),
          ),
          onPressed: () {
            AuthService _auth = AuthService();
            _auth.signOut();
          },
        ),
        decoration: BoxDecoration(
          color: Color(0xff2a2f35),
        ),
      ),
    );
  }
}

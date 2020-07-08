import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Models/user.dart';
import 'package:prearticle/Providers/search_Provider.dart';
import 'package:prearticle/Screens/Book_Details.dart';
import 'package:prearticle/Widgets/Book_Series_Widget.dart';
import 'package:prearticle/Widgets/Card_Swipe.dart';
import 'package:prearticle/notifier/Firebase_Auth_Notifier.dart';
import 'package:prearticle/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:prearticle/api/user_api.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  _HomePageState createState() => _HomePageState();
}

enum search { enable, disable }

class _HomePageState extends State<HomePage> {

  
  int currentIndex;
  var queryResultSet = [];
  var tempSearchStore = [];

  final TextEditingController _controller = new TextEditingController();
  search _search = search.disable;

  bool _loading = true;
  String _uid = '';
  String _name = '';
  String _email = '';
  String _admin = '';

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    if (user != null) {
      setState(() {
        _loading = false;
        _uid = user.uid;
        _name = user.name;
        _email = user.email;
      });
    }

    /* AuthNotifier authNotifier = Provider.of<AuthNotifier>(context); */
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff6e9bdf),
      /* appBar: AppBar(
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: Text(
          'PreArticle',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {setState(() {
                    _search = _search == search.enable
                        ? search.disable
                        : search.enable;
                  });},
          ),
        ],
        elevation: 0,
      ), */
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: SizedBox(
                height: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25, bottom: 30),
              child: Container(
                height: 50,
                width: SizeConfig.blockSizeHorizontal * 100,
                decoration: BoxDecoration(
                  color: _search == search.enable
                      ? Color(0xffe7f0ff)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                      child: IconButton(
                        
                        icon: _search == search.enable
                            ? Icon(Icons.menu)
                            : Icon(Icons.menu),
                        iconSize: 30.0,
                        color: _search == search.enable
                            ? Colors.grey[800]
                            : Colors.white,
                        onPressed: () {
                          setState(() {
                            _controller.clear();
                            _search = _search == search.enable
                                ? search.disable
                                : search.enable;
                          });
                        },
                      ),
                    ),
                    _search == search.enable
                        ? GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _dismissKeyboard(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: SizeConfig.blockSizeHorizontal * 100 - 150,
                              child: TextField(
                                onChanged: (val) {
                                  initiateSearch(val);
                                },
                                controller: _controller,
                                decoration: InputDecoration(
                                  hintText: 'Search Here',
                                  border: InputBorder.none,
                                ),
                              ),
                            ))
                        : Container(
                            child: Text(
                              'Welcome! ' + _name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.safeBlockHorizontal * 6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            /* Text(
                              authNotifier.user != null
                                  ? 'Welcome! ${authNotifier.user.displayName}'
                                  : 'Welcome! to PreArticle',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.safeBlockHorizontal * 6,
                                fontWeight: FontWeight.bold,
                              ),
                            ), */
                          ),
                      ],
                    ),
                    Container(
                      child: IconButton(
                        icon: _search == search.enable
                            ? Icon(Icons.close)
                            : Icon(Icons.search),
                        iconSize: 30.0,
                        color: _search == search.enable
                            ? Colors.grey[800]
                            : Colors.white,
                        onPressed: () {
                          setState(() {
                            _controller.clear();
                            _search = _search == search.enable
                                ? search.disable
                                : search.enable;
                          });
                        },
                      ),
                    ),
                    /* Container(
                      child: IconButton(
                        icon: _search == search.enable
                            ? Icon(Icons.exit_to_app)
                            : Icon(Icons.exit_to_app),
                        iconSize: 30.0,
                        color: _search == search.enable
                            ? Colors.grey[800]
                            : Colors.white,
                        onPressed: () {
                          /* AuthService _auth = AuthService();
                          _auth.signOut(); */
                        },
                      ),
                    ), */
                  ],
                ),
              ),
            ),
            /* Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 30, right: 20, top: 10, bottom: 10),
                  child: Container(
                    height: 90,
                    child: _search == search.enable
                        ? SafeArea(
                            child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffe7f0ff),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  width: SizeConfig.blockSizeHorizontal * 100 -
                                      100,
                                  child: TextField(
                                    onChanged: (val) {
                                      initiateSearch(val);
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Search Here',
                                      border: InputBorder.none,
                                      suffixIcon: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                        : Container(
                            child: SafeArea(
                            child: Text(
                              'Welcome! to PreArticle',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 30.0,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        _search = _search == search.enable
                            ? search.disable
                            : search.enable;
                      });
                    },
                  ),
                ),
              ],
            ), */
            Expanded(
                child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Book Series',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                          ),
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 15,
                            child: BookSeriesWidget(),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 15, bottom: 15, left: 20),
                          child: Text(
                            'Recently Added',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Expanded(child: CardSwipe())
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _dismissKeyboard(context);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.white,
                      elevation: 1,
                      child: ListView(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 0, bottom: 0),
                          primary: false,
                          shrinkWrap: true,
                          children: tempSearchStore.map((element) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BookDetails(name: element['Name']),
                                      settings: RouteSettings(
                                          arguments: element['Name'])),
                                );
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  elevation: 0,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          /* border: Border.all(
                                            color: Colors.black, width: 1) */
                                          ),
                                      height: 38,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            element['Name'],
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.search,
                                            size: 15,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ))),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ],
            ))
          ]),
    );
  }
}

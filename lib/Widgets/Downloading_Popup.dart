import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Providers/App_Provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DownloadAlert extends StatefulWidget {
  final String url;
  final String path;
  final String ipath;
  final String iurl;

  DownloadAlert(
      {Key key,
      @required this.url,
      @required this.path,
      @required this.iurl,
      @required this.ipath})
      : super(key: key);

  @override
  _DownloadAlertState createState() => _DownloadAlertState();
}

enum cancel { enable, disable }

class _DownloadAlertState extends State<DownloadAlert> {
  cancel _cancel = cancel.disable;
  Dio dio = new Dio();
  int received = 0;
  String progress = "0";
  int total = 0;

  download() async {
    dio.interceptors.add(LogInterceptor());
    // Token can be shared with different requests.
    CancelToken token = CancelToken();
    /* Timer(Duration(milliseconds: 500), () {
    token.cancel("cancelled");
  }); */
    await Future.wait([
      dio.download(
        widget.url,
        widget.path,
        deleteOnError: true,
        cancelToken: token,
        onReceiveProgress: (receivedBytes, totalBytes) async {
          setState(() {
            received = receivedBytes;
            total = totalBytes;
            progress = (received / total * 100).toStringAsFixed(0);
          });

          //Check if download is complete and close the alert dialog
          /* if (receivedBytes == totalBytes) {
          Navigator.pop(context, "${AppProvider.formatBytes(total, 1)}");
        } */
          if (_cancel == cancel.enable) {
            File epubfile = File(widget.path);
            File imagefile = File(widget.ipath);
            if (await epubfile.exists()) {
              await epubfile.delete();
            }
            if (await imagefile.exists()) {
              await imagefile.delete();
            }
            token.cancel("cancelled");
            Navigator.pop(context, "${AppProvider.formatBytes(total, 1)}");
          }
        },
      ) /* .catchError(
      (e) {
        if (CancelToken.isCancel(e)) {
          print('Error: $e');
        }
      },
    ) */
      ,
      dio.download(
        widget.iurl,
        widget.ipath,
        deleteOnError: true,
        cancelToken: token,
        onReceiveProgress: (receivedBytes, totalBytes) async {
          /* setState(() {
          received = receivedBytes;
          total = totalBytes;
          progress = (received / total * 100).toStringAsFixed(0);
        }); */

          //Check if download is complete and close the alert dialog
          /* if (receivedBytes == totalBytes) {
          Navigator.pop(context, "${AppProvider.formatBytes(total, 1)}");
        } */
          if (_cancel == cancel.enable) {
            File epubfile = File(widget.path);
            File imagefile = File(widget.ipath);
            if (await epubfile.exists()) {
              await epubfile.delete();
            }
            if (await imagefile.exists()) {
              await imagefile.delete();
            }
            token.cancel("cancelled");
            Navigator.pop(context, "${AppProvider.formatBytes(total, 1)}");
          }
        },
      ) /* .catchError(
      (e) {
        if (CancelToken.isCancel(e)) {
          print('Error: $e');
        }
      },
    ), */
    ]).then((value) =>
        Navigator.pop(context, "${AppProvider.formatBytes(total, 1)}"));
  }

  @override
  void initState() {
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    File epubfile = File(widget.path);
    File imagefile = File(widget.ipath);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
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
                                  _cancel = _cancel == cancel.enable
                                      ? cancel.disable
                                      : cancel.enable;
                                });
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
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            /* borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ), */
                          ),
                          child: LiquidLinearProgressIndicator(
                            value: double.parse(progress) / 100, // Defaults to 0.5.
                            valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor.withOpacity(0.8)), // Defaults to the current Theme's accentColor.
                            backgroundColor: Theme.of(context).accentColor.withOpacity(0.3), // Defaults to the current Theme's backgroundColor.
                            borderColor: Theme.of(context).accentColor.withOpacity(1),
                            borderWidth: 2.0,
                            borderRadius: 5.0,
                            direction: Axis
                                .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                            center: Text("Downloading...", style: TextStyle(color: Colors.white),),
                          ),
                          /* LinearProgressIndicator(
                        value: double.parse(progress) / 100,
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor),
                        backgroundColor:
                            Theme.of(context).accentColor.withOpacity(0.3),
                      ), */
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 30, right: 30, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "$progress %",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${AppProvider.formatBytes(received, 1)} "
                              "of ${AppProvider.formatBytes(total, 1)}",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
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

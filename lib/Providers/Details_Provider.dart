import 'dart:html';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prearticle/Database/Downloads_Database.dart';

class DetailsProvider extends ChangeNotifier {

  String message;
  bool loading = true;
  Entry entry;
  var dlDB = DownloadsDB();
  bool downloaded = false;

  Future<List> getDownload() async {
    List c = await dlDB.check ({"id": entry.published.t});
    return c;
  }

    addDownload(Map body) async {
    await dlDB.add(body);
    checkDownload();
  }

    checkDownload() async {
    List c = await dlDB.check ({"id": entry.published.t});
    if(c.isNotEmpty) {
      setDownloaded(true);
    } else {
      setDownloaded(false);
    }
  }

  void setDownloaded(value) {
    downloaded = value;
    notifyListeners();
  }
}
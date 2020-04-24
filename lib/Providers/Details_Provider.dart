import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prearticle/Database/Downloads_Database.dart';

class DetailsProvider extends ChangeNotifier {

  String message;
  bool loading = true;
  var dlDB = DownloadsDB();
  bool downloaded = false;

/*   Future<List> getDownload() async {
    List c = await dlDB.check ({"id": entry.published.t});
    return c;
  }
 */
    addDownload(Map body) async {
    await dlDB.add(body);
    print('Kucch to hua abhi abhi');
    checkDownload(body['id']);
  }

    checkDownload(String id) async {
    List c = await dlDB.check ({"id": id});
    if(c.isNotEmpty) {
      setDownloaded(true);
    } else {
      setDownloaded(false);
      return null;
    }
  }

  void setDownloaded(value) {
    downloaded = value;
    notifyListeners();
    print(downloaded);
  }

  Future<List> getDownload(String id) async{
    if (dlDB.check({"name": id}) != null) {
    List c = await dlDB.check({"name": id});
    return c;
    }
    else {
      return null;
    }
  }

}


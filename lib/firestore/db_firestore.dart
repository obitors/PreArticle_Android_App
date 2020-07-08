import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prearticle/constants/constants.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Document<T> {
  final Firestore _db = Firestore.instance;
  final String path;
  DocumentReference ref;

  Document({this.path}) {
    ref = _db.document(path);
  }

  Future<T> getData() {
    return ref.get().then((v) => Globals.models[T](v.data) as T);
  }

  Stream<T> streamData() {
    return ref.snapshots().map((v) => Globals.models[T](v.data) as T);
  }

  Future<void> upsert(Map data) {
    return ref.setData(Map<String, dynamic>.from(data), merge: true);
  }

  Future<void> delete() async {
    print('delete: $path');
    await ref.delete();
  }
}

class Collection<T> {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Collection({this.path}) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    var snapshots = await ref.getDocuments();
    return snapshots.documents
        .map((doc) => Globals.models[T](doc.data) as T)
        .toList();
  }

  Stream<List<T>> streamData() {
    return ref.snapshots().map((list) =>
        list.documents.map((doc) => Globals.models[T](doc.data) as T));
  }
}

class UserData<T> {
  //final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collection;

  UserData({this.collection});

  Stream<T> get documentStream {
    return _auth.onAuthStateChanged.switchMap((user) {
      if (user != null) {
        Document<T> doc = Document<T>(path: '$collection/${user.uid}');
        return doc.streamData();
      } else {
        return Stream<T>.value(null);
      }
    });
  }

  Future<T> getDocument() async {
    FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      Document doc = Document<T>(path: '$collection/${user.uid}');
      return doc.getData();
    } else {
      return null;
    }
  }

  Future<void> upsert(Map data) async {
    FirebaseUser user = await _auth.currentUser();
    Document<T> ref = Document(path: '$collection/${user.uid}');
    return ref.upsert(data);
  }
}

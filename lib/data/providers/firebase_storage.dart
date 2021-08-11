import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/config/extensions.dart';

class FirebaseStorageClient {
  FirebaseStorageClient({FirebaseStorage firebaseFirestore})
      : _firebaseStorage = firebaseFirestore ?? FirebaseStorage.instance;

  final FirebaseStorage _firebaseStorage;

  Future<String> uploadFile(
      {@required File file, @required String path}) async {
    final milliSecs = ESTDateTime.fetchTimeEST().millisecondsSinceEpoch;
    final ref = _firebaseStorage.ref().child('$path/$milliSecs\_avatar');
    await ref.putFile(file);
    final url = await ref.getDownloadURL();
    return url;
  }
}

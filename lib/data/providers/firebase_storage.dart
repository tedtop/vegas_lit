import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../config/extensions.dart';

class FirebaseStorageClient {
  FirebaseStorageClient({FirebaseStorage? firebaseFirestore})
      : _firebaseStorage = firebaseFirestore ?? FirebaseStorage.instance;

  final FirebaseStorage _firebaseStorage;

  Future<String> uploadFile({required File file, required String? path}) async {
    final milliSecs = ESTDateTime.fetchTimeEST().millisecondsSinceEpoch;
    // ignore: unnecessary_string_escapes
    final ref = _firebaseStorage.ref().child('$path/$milliSecs\_avatar');
    await ref.putFile(file);
    final url = await ref.getDownloadURL();
    return url;
  }
}

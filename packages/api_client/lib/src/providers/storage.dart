import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../base_provider.dart';

class StorageProvider extends BaseStorageProvider {
  StorageProvider({FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  final FirebaseStorage _firebaseStorage;

  @override
  Future<String> uploadFile(File file, String path) async {
    final fileName = basename(file.path);
    final miliSecs = DateTime.now().millisecondsSinceEpoch;
    final reference =
        _firebaseStorage.ref().child('$path/$miliSecs\_$fileName');

    final uploadTask = await reference.putFile(file);

    final url = await uploadTask.ref.getDownloadURL();
    return url;
  }
}

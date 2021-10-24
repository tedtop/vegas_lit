import 'dart:io';

import '../providers/firebase_storage.dart';

class StorageRepository {
  final _storageClient = FirebaseStorageClient();

  Future<String> uploadFile({required File file, required String? path}) =>
      _storageClient.uploadFile(file: file, path: path);
}

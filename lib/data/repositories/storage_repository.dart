import 'dart:io';

import '../providers/firebase_storage.dart';

class StorageRepository {
  StorageRepository({FirebaseStorageClient? storageClient})
      : _storageClient = storageClient ?? FirebaseStorageClient();

  final FirebaseStorageClient _storageClient;

  Future<String> uploadFile({required File file, required String? path}) =>
      _storageClient.uploadFile(file: file, path: path);
}

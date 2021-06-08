import 'dart:io';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/providers/firebase_storage.dart';

class StorageRepository {
  final _storageClient = CloudStorageClient();

  Future<String> uploadFile({@required File file, @required String path}) =>
      _storageClient.uploadFile(file: file, path: path);
}

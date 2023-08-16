import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:storeonline/firebase/models/image_model.dart';

class FbStorageController {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<ImageModel?> uploadFile(File? file, {required String path}) async {
    if (file == null) return null;

    var data = await _storage
        .ref()
        .child('$path/${DateTime.now().toString()}')
        .putFile(file);
    String link = await data.ref.getDownloadURL();
    String fullPath = data.ref.fullPath;

    return ImageModel(link: link, path: fullPath);
  }

  Future<void> delete(String path) async {
    await _storage.ref().child(path).delete();
  }
}

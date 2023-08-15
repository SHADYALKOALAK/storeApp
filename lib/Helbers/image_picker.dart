import 'dart:io';
import 'package:image_picker/image_picker.dart';

mixin ImagePikerHelper {
  final ImagePicker _picker = ImagePicker();

  Future<File?> choseImage(ImageSource source) async {
    XFile? file = await _picker.pickImage(source: source);
    if (file == null) return null;
    return File(file.path);
  }

  Future<List<File>> choseMaltyImage() async {
    var file = await _picker.pickMultiImage();
    return file.map((e) => File(e.path)).toList();
  }


}

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

mixin ConverterHelper {
  Future<File> convertLinkToFile(String link) async {
    var url = Uri.parse(link);
    var response = await http.get(url);
    var directory = await getApplicationDocumentsDirectory();
    File file = File(join(directory.path, '${DateTime.now()}.png'));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}

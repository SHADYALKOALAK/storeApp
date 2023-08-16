import 'package:flutter/foundation.dart';
import 'package:storeonline/enums.dart';
import 'package:storeonline/providers/cache/cache_controller.dart';


class LanguageProvider extends ChangeNotifier {
  String language = CacheController().getter(CacheKeys.language) ?? 'en';

  Future<void> changeLanguage() async {
    language = language == 'ar' ? 'en' : 'ar';
    await CacheController().setter(CacheKeys.language, language);
    notifyListeners();
  }

  Future<void> setLanguage(String lang) async {
    language = lang;
    await CacheController().setter(CacheKeys.language, lang);
    notifyListeners();
  }
}

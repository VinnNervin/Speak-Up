import 'package:flutter/foundation.dart';

class LanguageController with ChangeNotifier {
  String _selectedLanguageCode = 'en'; // default 'en'

  String get selectedLanguageCode => _selectedLanguageCode;

  String get selectedLanguageFlag {
    if (_selectedLanguageCode == 'zh') {
      return 'assets/images/flags/chinese.png';
    }
    return 'assets/images/flags/english.png';
  }

  String get selectedLanguageName {
    if (_selectedLanguageCode == 'zh') {
      return 'Chinese';
    }
    return 'English';
  }

  String get selectedLanguageNativeName {
    if (_selectedLanguageCode == 'zh') {
      return '中文';
    }
    return 'English';
  }

  void changeLanguage(String code) {
    if (code == _selectedLanguageCode) return;
    if (code == 'en' || code == 'zh') {
      _selectedLanguageCode = code;
      notifyListeners();
    }
  }
}

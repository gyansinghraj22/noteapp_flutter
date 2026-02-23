import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale(kDebugMode ? "en" : "ja"));
  // void changeLanguage(String language) async {
  //   if (language.isEmpty) {
  //     SharedPref.setStringValue(KeyString.languageKey.name, "English");
  //   }

  //   emit(Locale(language.isNotEmpty ? getLanguageCode(language) : "ja", ''));
  // }
}

Map iSOLanguageCode = {"ENG": "en", "JPN": "ja"};

Map lLanguageName = {"en": "ENG", "ja": "JPN"};

getLanguageCode(String language) {
  if (iSOLanguageCode.containsKey(language)) {
    return iSOLanguageCode[language];
  }
}

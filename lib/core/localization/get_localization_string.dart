import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/constants/res_string.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations({required this.locale});

  Map<String, String>? _localizedValues;
  Map<String, String>? englishMap;

  Future load() async {
    String jsonStringValues = await rootBundle.loadString(
      "assets/l10n/${locale.languageCode}.arb",
    );
    String jsonEnglishStringValues = await rootBundle.loadString(
      "assets/l10n/en.arb",
    );

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, dynamic> englishMappedJson = json.decode(
      jsonEnglishStringValues,
    );

    _localizedValues = mappedJson.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    englishMap = englishMappedJson.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String? getTranslatedValue(String key) {
    if (_localizedValues![key] == null) {
      return englishMap![key];
    } else {
      return _localizedValues![key];
    }
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _DemoLocalizationDelegate();
}

class _DemoLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _DemoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ja'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

String getLocalizedString({
  required BuildContext? context,
  required ResString resString,
}) {
  String keyvalue = resString.name;

  String? localizedString = AppLocalizations.of(
    context!,
  )?.getTranslatedValue(keyvalue);
  return localizedString ?? "";
}

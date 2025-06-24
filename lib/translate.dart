import 'package:flutter/material.dart';
import 'package:flutter_translate/yaml_utils.dart';
import 'package:intl/intl.dart';

part 'translate_loader.dart';
part 'translate_mixin.dart';

class I18nTranslate {
  static final Map<String, dynamic> _dictionary = <String, dynamic>{};
  static late I18nTranslate _instance;

  static I18nTranslate get instance => _instance;
  static late List<TranslateLoader> _loaderList;

  I18nTranslate._internal(Map<String, dynamic> dict) {
    _dictionary.addAll(dict);
  }

  static Future<Map<String, dynamic>> getDictFromLoaders() async {
    final List<Map<String, dynamic>> allDecodedMap = await Future.wait(_loaderList.map((loader) => loader.load()));
    final Map<String, dynamic> dict = <String, dynamic>{};

    for (int index = 0; index < allDecodedMap.length; index++) {
      final Map<String, dynamic> decodedMap = allDecodedMap[index];
      final TranslateLoader loader = _loaderList[index];
      if (dict[loader.dictId] == null) {
        dict[loader.dictId] = {};
      }

      Map.from(dict[loader.dictId]).addAll(decodedMap);
    }

    return dict;
  }

  static Future<void> create({required List<TranslateLoader> loaders}) async {
    _loaderList = loaders;
    final Map<String, dynamic> dict = await getDictFromLoaders();

    if (_dictionary.entries.isEmpty) {
      _instance = I18nTranslate._internal(dict);
    } else {
      _dictionary.addAll(dict);
    }
  }

  static Future<void> refresh(Locale locale) async {
    final newLoaderList = _loaderList.map((loader) => loader.copyWith(locale: locale)).toList();
    create(loaders: newLoaderList);
  }

  String _applyParams(String value, Map<String, String>? params) {
    if (params == null) {
      return value;
    }

    String result = value;
    for (final MapEntry<String, String> param in params.entries) {
      result = result.replaceAll('{${param.key}}', param.value);
    }

    return result;
  }

  String translate(String key, {String dictId = 'default', Map<String, String>? params}) {
    final List<String> parts = key.split('.');

    if (parts.length == 1) {
      if (_dictionary[dictId] == null) {
        return key;
      }

      return (_dictionary[dictId][key] ?? key).replaceAll('\\n', '\n');
    }

    Map<String, dynamic> node = _dictionary[dictId] ?? <String, dynamic>{};
    if (node.entries.isEmpty) {
      return key;
    }

    for (int i = 0; i <= parts.length - 2; i++) {
      if (node[parts[i]] != null) {
        node = Map<String, dynamic>.from(node[parts[i]]);
      }
    }

    final String value = (node[parts.last] ?? key).replaceAll('\\n', '\n');
    return _applyParams(value, params);
  }

  String translateCurrency(
    double amount, {
    String format = 'R\$ #,##0.00',
    Locale? locale,
  }) {
    final Locale internalLocale = locale ?? WidgetsBinding.instance.platformDispatcher.locale;
    final NumberFormat formatter = NumberFormat(format, internalLocale.toString());
    return formatter.format(amount);
  }

  String translateDate(
    DateTime date, {
    String format = 'dd/MM/yyyy',
    Locale? locale,
  }) {
    final Locale internalLocale = locale ?? WidgetsBinding.instance.platformDispatcher.locale;
    final DateFormat formatter = DateFormat(format, internalLocale.toString());
    return formatter.format(date);
  }
}

part of 'translate.dart';

class TranslateLoader {
  final String dictId;
  final String basePath;
  final Locale? locale;

  TranslateLoader({
    this.basePath = 'assets/i18n',
    this.locale = const Locale('pt', 'BR'),
    this.dictId = 'default',
  });

  TranslateLoader copyWith({
    String? dictId,
    String? basePath,
    Locale? locale,
  }) {
    return TranslateLoader(
      dictId: dictId ?? this.dictId,
      basePath: basePath ?? this.basePath,
      locale: locale ?? this.locale,
    );
  }

  Future<Map<String, dynamic>> load() async {
    final YamlUtils yamlUtils = YamlUtils();
    final Locale internalLocale = locale ?? WidgetsBinding.instance.platformDispatcher.locale;
    return yamlUtils.loadYamlFromPath('$basePath/${internalLocale.toString().toLowerCase()}.yaml');
  }
}

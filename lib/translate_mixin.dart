part of 'translate.dart';

mixin I18nTranslateMixin {
  late final String _base;
  late final String _dictId;

  void setBaseTranslate({String? base, String? dictId}) {
    _base = base ?? '';
    _dictId = dictId ?? 'default';
  }

  String translate(
    String key, {
    bool useBaseTranslate = true,
    Map<String, String>? params,
    String? dictId,
  }) {
    return I18nTranslate.instance.translate(
      '${useBaseTranslate ? '$_base.' : ''}$key',
      dictId: dictId ?? _dictId,
      params: params,
    );
  }

  String translateCurrency(
    double amount, {
    String format = 'R\$ #,##0.00',
    Locale? locale,
  }) {
    return I18nTranslate.instance.translateCurrency(
      amount,
      format: format,
      locale: locale,
    );
  }

  String translateDate(
    DateTime date, {
    String format = 'dd/MM/yyyy',
    Locale? locale,
  }) {
    return I18nTranslate.instance.translateDate(
      date,
      format: format,
      locale: locale,
    );
  }
}

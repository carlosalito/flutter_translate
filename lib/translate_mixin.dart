part of 'translate.dart';

mixin I18nTranslateMixin {
  String _base = '';
  String _dictId = 'default';

  void setBaseTranslate({String? base, String? dictId}) {
    _base = base ?? '';
    _dictId = dictId ?? 'default';
  }

  String translate(
    String key, {
    bool useBaseTranslate = true,
    Map<String, String>? params,
  }) {
    return I18nTranslate.instance.translate(
      '${useBaseTranslate ? '$_base.' : ''}$key',
      dictId: _dictId,
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

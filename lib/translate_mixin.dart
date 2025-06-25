part of 'translate.dart';

mixin I18nTranslateMixin {
  String translate(
    String key, {
    Map<String, String>? params,
    String? dictId,
  }) {
    return I18nTranslate.instance.translate(
      key,
      dictId: dictId ?? 'default',
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

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
}

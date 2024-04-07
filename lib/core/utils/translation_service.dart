import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  Future<T> translateModel<T>(T model, String targetLanguage) async {
    final translatedModel = await _translateObject(model, targetLanguage);
    return translatedModel as T;
  }

  Future<dynamic> _translateObject(
      dynamic object, String targetLanguage) async {
    if (object is Map) {
      return await _translateMap(
          object.cast<String, dynamic>(), targetLanguage);
    } else if (object is List) {
      return await _translateList(object, targetLanguage);
    } else if (object != null) {
      return await _translatePrimitive(object, targetLanguage);
    }
    return object;
  }

  Future<Map<String, dynamic>> _translateMap(
    Map<String, dynamic> map,
    String targetLanguage,
  ) async {
    final translatedMap = <String, dynamic>{};
    for (final entry in map.entries) {
      final key = entry.key;
      final value = await _translateObject(entry.value, targetLanguage);
      translatedMap[key] = value;
    }
    return translatedMap;
  }

  Future<List<dynamic>> _translateList(
    List<dynamic> list,
    String targetLanguage,
  ) async {
    final translatedList = <dynamic>[];
    for (final item in list) {
      final translatedItem = await _translateObject(item, targetLanguage);
      translatedList.add(translatedItem);
    }
    return translatedList;
  }

  Future<dynamic> _translatePrimitive(
    dynamic value,
    String targetLanguage,
  ) async {
    if (value is String) {
      return await _translator.translate(value, to: targetLanguage);
    }
    return value;
  }
}

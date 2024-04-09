import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator translator = GoogleTranslator();

  Future<Translatable> translateEntity(
      Translatable entity, String targetLang) async {
    // Translate the top-level entity's fields
    var fieldsToTranslate = entity.getTranslatableFields();
    Map<String, dynamic> translatedFields = {};

    for (var fieldName in fieldsToTranslate.keys) {
      var originalText = fieldsToTranslate[fieldName];
      if (originalText is String) {
        var translation =
            await translator.translate(originalText, to: targetLang);
        translatedFields[fieldName] = translation.text;
      }
    }

    entity.updateWithTranslatedFields(translatedFields);

    // Translate any nested Translatable entities
    var nestedTranslatables = entity.getNestedTranslatables();
    for (Translatable nested in nestedTranslatables) {
      await translateEntity(nested, targetLang);
    }

    return entity;
  }
}

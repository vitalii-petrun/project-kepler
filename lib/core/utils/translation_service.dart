import 'package:project_kepler/data/models/article_dto.dart';
import 'package:project_kepler/data/models/event2_dto.dart';
import 'package:project_kepler/data/models/launch_dto.dart';

import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator translator = GoogleTranslator();

  Future<T> translateModel<T>(T model, String targetLang) async {
    if (model is LaunchDTO) {
      return await _translateLaunchDTO(model, targetLang) as T;
    } else if (model is EventDTO) {
      return await _translateEventDTO(model, targetLang) as T;
    } else if (model is ArticleDTO) {
      return await _translateArticleDTO(model, targetLang) as T;
    } else {
      throw Exception('Internal Error: Unsupported model type');
    }
  }

  Future<String> translateText(String text,
      {String from = 'auto', required String to}) async {
    var translation = await translator.translate(text, from: from, to: to);
    return translation.text;
  }

  Future<LaunchDTO> _translateLaunchDTO(
      LaunchDTO model, String targetLang) async {
    Map<String, dynamic> modelMap = model.toJson();

    // Translate each field
    for (String key in modelMap.keys) {
      if (modelMap[key] is String && key != 'description') {
        modelMap[key] = await translateText(modelMap[key], to: targetLang);
      }
    }

    return LaunchDTO.fromJson(modelMap);
  }

  Future<EventDTO> _translateEventDTO(EventDTO model, String targetLang) async {
    Map<String, dynamic> modelMap = model.toJson();

    // Translate each field
    for (String key in modelMap.keys) {
      if (modelMap[key] is String && key != 'description') {
        modelMap[key] = await translateText(modelMap[key], to: targetLang);
      }
    }

    return EventDTO.fromJson(modelMap);
  }

  Future<ArticleDTO> _translateArticleDTO(
      ArticleDTO model, String targetLang) async {
    Map<String, dynamic> modelMap = model.toJson();

    // Translate each field
    for (String key in modelMap.keys) {
      if (modelMap[key] is String && key != 'summary') {
        modelMap[key] = await translateText(modelMap[key], to: targetLang);
      }
    }

    return ArticleDTO.fromJson(modelMap);
  }
}

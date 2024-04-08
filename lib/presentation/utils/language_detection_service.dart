import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/core/utils/translation_service.dart';
import 'package:project_kepler/l10n/locale_provider.dart';

class LanguageDetectionService {
  final TranslationService _translationService;
  final LocaleProvider _localeProvider;

  LanguageDetectionService(this._translationService, this._localeProvider);

  Future<T> translateIfNeeded<T>(T model) async {
    final currentLocale = _localeProvider.currentLocale;
    const defaultLocale = 'en';

    if (currentLocale != defaultLocale) {
      if (model is List) {
        logger.d('Translating list');
        return await translateList(model) as T;
      }
      logger.d('Translating model');
      return await _translationService.translateModel(model, currentLocale);
    }

    return model;
  }

  Future<List<T>> translateList<T>(List<T> list) async {
    final translatedList = <T>[];

    for (var element in list) {
      logger.d('Translating element of type: ${element.runtimeType}');
      final translatedElement = await _translationService.translateModel(
          element, _localeProvider.currentLocale);
      translatedList.add(translatedElement);
    }
    return translatedList;
  }
}

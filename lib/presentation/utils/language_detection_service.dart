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
    logger.d('Current locale: $currentLocale');
    if (currentLocale != defaultLocale) {
      logger.d('Translating model to $currentLocale');
      return await _translationService.translateModel(model, currentLocale);
    }
    logger.d('No translation needed');
    return model;
  }
}

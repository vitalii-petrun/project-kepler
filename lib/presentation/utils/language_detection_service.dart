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
      return await _translationService.translateModel(model, currentLocale);
    }

    return model;
  }
}

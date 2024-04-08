import 'package:project_kepler/core/utils/translation_service.dart';
import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/l10n/locale_provider.dart';

/// Detects the language of the current locale and translates the model if needed.
class LanguageDetectionService {
  final TranslationService _translationService;
  final LocaleProvider _localeProvider;

  LanguageDetectionService(this._translationService, this._localeProvider);

  Future<Translatable> translateIfNecessary(Translatable model) async {
    final currentLocale = _localeProvider.currentLocale;
    const defaultLocale = 'en';

    if (currentLocale != defaultLocale &&
        model.getTranslatableFields().isNotEmpty) {
      return await _translationService.translateEntity(model, currentLocale);
    }

    return model;
  }
}

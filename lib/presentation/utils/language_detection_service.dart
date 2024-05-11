import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_kepler/core/utils/translation_service.dart';
import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/l10n/locale_provider.dart';

class LanguageDetectionService {
  /// Detects the language of the current locale and translates the model if needed.
  final TranslationService _translationService;
  final LocaleProvider _localeProvider;

  LanguageDetectionService(this._translationService, this._localeProvider);

  Future<Translatable> translateIfNecessary(Translatable model) async {
    final currentLocale = _localeProvider.currentLocale;
    const defaultLocale = 'en';
    //Due to additional time consumption, translation can be disabled.
    final isTranslationEnabled =
        dotenv.env['API_TRANSLATION_ENABLED'] == 'true';

    if (currentLocale != defaultLocale &&
        model.getTranslatableFields().isNotEmpty &&
        isTranslationEnabled) {
      return await _translationService.translateEntity(model, currentLocale);
    }

    return model;
  }
}

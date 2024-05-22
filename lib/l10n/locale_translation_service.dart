import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:project_kepler/core/utils/translation_service.dart';
import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/l10n/locale_provider.dart';

class LocaleTranslationService extends ChangeNotifier {
  final TranslationService _translationService;
  final LocaleProvider _localeProvider;

  LocaleTranslationService(this._translationService, this._localeProvider) {
    _localeProvider.addListener(_onLocaleChanged);
  }

  Future<Translatable> translateIfNecessary(Translatable model) async {
    final currentLocale = _localeProvider.currentLocale;
    const defaultLocale = 'en';
    final isTranslationEnabled =
        dotenv.env['API_TRANSLATION_ENABLED'] == 'true';

    if (currentLocale != defaultLocale &&
            isTranslationEnabled &&
            model.getTranslatableFields().isNotEmpty ||
        model.getNestedTranslatables().isNotEmpty) {
      return await _translationService.translateEntity(model, currentLocale);
    }

    return model;
  }

  void _onLocaleChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _localeProvider.removeListener(_onLocaleChanged);
    super.dispose();
  }
}

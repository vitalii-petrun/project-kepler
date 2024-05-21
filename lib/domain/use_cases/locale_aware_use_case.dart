import 'package:flutter/material.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

abstract class LocaleAwareUseCase extends ChangeNotifier {
  final LocaleTranslationService localeTranslationService;

  LocaleAwareUseCase(this.localeTranslationService) {
    localeTranslationService.addListener(_onLocaleChanged);
  }

  void _onLocaleChanged() {
    onLocaleChanged();
  }

  void onLocaleChanged();

  @override
  void dispose() {
    localeTranslationService.removeListener(_onLocaleChanged);
    super.dispose();
  }
}

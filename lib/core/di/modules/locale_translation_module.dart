import 'package:injectable/injectable.dart';
import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/core/utils/translation_service.dart';
import 'package:project_kepler/l10n/locale_provider.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

@module
abstract class LocaleTranslationModule {
  @singleton
  TranslationService get translationService => TranslationService();
  @singleton
  LocaleTranslationService get localeTranslationService =>
      LocaleTranslationService(
        locator<TranslationService>(),
        locator<LocaleProvider>(),
      );
}

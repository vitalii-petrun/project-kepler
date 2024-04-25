import 'package:injectable/injectable.dart';
import 'package:project_kepler/core/utils/translation_service.dart';
import 'package:project_kepler/l10n/locale_provider.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';

@module
abstract class LanguageDetectionModule {
  @singleton
  TranslationService get translationService => TranslationService();

  @singleton
  LocaleProvider get localeProvider => LocaleProvider()..initialize();

  @singleton
  LanguageDetectionService get languageDetectionService =>
      LanguageDetectionService(translationService, localeProvider);
}

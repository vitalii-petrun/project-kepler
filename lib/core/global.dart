import 'package:logger/logger.dart';
import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/core/utils/translation_service.dart';
import 'package:project_kepler/l10n/locale_provider.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

Logger logger = Logger();
final localeProvider = locator<LocaleProvider>();

final translationService = TranslationService();
final localeTranslationService =
    LocaleTranslationService(translationService, localeProvider);
    // LanguageDetectionService(translationService, localeProvider);

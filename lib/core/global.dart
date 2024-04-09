import 'package:logger/logger.dart';
import 'package:project_kepler/core/utils/translation_service.dart';
import 'package:project_kepler/l10n/locale_provider.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';

Logger logger = Logger();
final localeProvider = LocaleProvider()..initialize();
final translationService = TranslationService();
final languageDetectionService =
    LanguageDetectionService(translationService, localeProvider);

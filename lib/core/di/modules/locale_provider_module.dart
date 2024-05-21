import 'package:injectable/injectable.dart';
import 'package:project_kepler/l10n/locale_provider.dart';

@module
abstract class LocaleProviderModule {
  @singleton
  LocaleProvider get localeProvider => LocaleProvider()..initialize();
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data%20sources/remote/api_client.dart' as _i7;
import '../../l10n/locale_provider.dart' as _i5;
import '../../presentation/utils/language_detection_service.dart' as _i6;
import '../utils/translation_service.dart' as _i4;
import 'modules/api_client_module.dart' as _i8;
import 'modules/language_detection_module.dart' as _i9;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $configureDependencies(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final apiClientModule = _$ApiClientModule();
  final languageDetectionModule = _$LanguageDetectionModule();
  gh.singleton<_i3.Dio>(() => apiClientModule.dio);
  gh.singleton<_i4.TranslationService>(
      () => languageDetectionModule.translationService);
  gh.singleton<_i5.LocaleProvider>(
      () => languageDetectionModule.localeProvider);
  gh.singleton<_i6.LanguageDetectionService>(
      () => languageDetectionModule.languageDetectionService);
  gh.singleton<_i7.ApiClient>(() => apiClientModule.apiClient(gh<_i3.Dio>()));
  return getIt;
}

class _$ApiClientModule extends _i8.ApiClientModule {}

class _$LanguageDetectionModule extends _i9.LanguageDetectionModule {}

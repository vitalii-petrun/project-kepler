import 'dart:ui';

enum AppLocale {
  en,
  uk;

  const AppLocale();

  Locale get locale {
    switch (this) {
      case AppLocale.en:
        return const Locale('en');
      case AppLocale.uk:
        return const Locale('uk');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_kepler/core/utils/auth_state_handler.dart';
import 'package:project_kepler/core/utils/provider_initializer.dart';
import 'package:project_kepler/data/data%20sources/remote/api_client.dart';
import 'package:project_kepler/l10n/locale_provider.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:provider/provider.dart';
import '../presentation/navigation/app_router.dart';

class Application extends StatefulWidget {
  final AppRouter appRouter;
  final ApiClient apiClient;
  final ApiClient newsApiClient;
  final AuthenticationCubit authenticationCubit;
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  const Application({
    required this.appRouter,
    required this.apiClient,
    required this.newsApiClient,
    required this.authenticationCubit,
    Key? key,
  }) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    setHighRefreshRate();
    super.initState();
  }

  void setHighRefreshRate() async {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInitializer.initializeProviders(
        widget.apiClient,
        widget.newsApiClient,
        widget.authenticationCubit,
      ),
      child: Consumer2<AppThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) {
          return AuthStateHandler(
            child: MaterialApp.router(
              scaffoldMessengerKey: Application._scaffoldMessengerKey,
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              themeMode: themeProvider.themeMode,
              locale: Locale(localeProvider.currentLocale),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: widget.appRouter.config(),
            ),
          );
        },
      ),
    );
  }
}

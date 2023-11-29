import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_kepler/l10n/locale_provider.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/blocs/favourite_launches_page/favourite_launches_page_cubit.dart';
import 'package:project_kepler/presentation/blocs/friends_page/friends_page_cubit.dart';
import 'package:project_kepler/presentation/blocs/launch_details/launch_details_page_cubit.dart';
import 'package:project_kepler/presentation/blocs/launches/launches_page_cubit.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:provider/provider.dart';
import '../data/repositories/api_repository_impl.dart';
import '../presentation/blocs/home_page/home_page_cubit.dart';
import '../presentation/blocs/users_page/users_page_cubit.dart';
import '../presentation/navigation/app_router.dart';
import '../presentation/widgets/app_navigation/active_tab_index_provider.dart';

class Application extends StatelessWidget {
  final AppRouter appRouter;
  final AuthenticationCubit authenticationCubit;
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  const Application({
    required this.appRouter,
    required this.authenticationCubit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: ((_) => AppThemeProvider()..initialize())),
        ChangeNotifierProvider(create: ((_) => LocaleProvider()..initialize())),
        ChangeNotifierProvider(create: ((_) => ActiveTabIndexProvider())),
        BlocProvider(
          create: (context) => HomePageCubit(ApiRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => LaunchesPageCubit(ApiRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => LaunchDetailsPageCubit(ApiRepositoryImpl()),
        ),
        BlocProvider(create: (context) => FriendsPageCubit()),
        BlocProvider(create: (context) => UsersPageCubit()),
        BlocProvider(create: (context) => FavoriteLaunchesPageCubit()),
        BlocProvider.value(value: authenticationCubit),
      ],
      child: Consumer2<AppThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) {
          return MaterialApp.router(
            scaffoldMessengerKey: _scaffoldMessengerKey,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: Locale(localeProvider.currentLocale),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: appRouter.config(),
          );
        },
      ),
    );
  }
}

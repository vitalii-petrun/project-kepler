import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_kepler/data/data%20sources/remote/api_client.dart';
import 'package:project_kepler/data/repositories/article_repository_impl.dart';
import 'package:project_kepler/data/repositories/firestore_user_repository.dart';
import 'package:project_kepler/domain/use_cases/get_all_launches_use_case.dart';
import 'package:project_kepler/domain/use_cases/get_upcoming_launches_use_case.dart';
import 'package:project_kepler/l10n/locale_provider.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/cubits/events_page/events_cubit.dart';
import 'package:project_kepler/presentation/cubits/favourite_launches_page/favourite_launches_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/friends_page/friends_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/launch_details/launch_details_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/launches/launches_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/launches/upcoming_launches_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/blogs_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/nasa_news_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_cubit.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:provider/provider.dart';
import '../data/repositories/api_repository_impl.dart';
import '../domain/converters/launch_converter.dart';
import '../domain/use_cases/fetch_articles_use_case.dart';
import '../domain/use_cases/fetch_blogs_use_case.dart';
import '../domain/use_cases/fetch_favourite_launches_use_case.dart';
import '../domain/use_cases/fetch_friends_use_case.dart';
import '../domain/use_cases/fetch_nasa_articles_use_case.dart';
import '../domain/use_cases/fetch_spacex_articles_use_case.dart';
import '../domain/use_cases/get_all_events_use_case.dart';
import '../domain/use_cases/get_launch_details_use_case.dart';
import '../domain/use_cases/remove_favourite_launch_use_case.dart';
import '../domain/use_cases/set_favourite_launch_use_case.dart';
import '../presentation/cubits/authentication/authentication_state.dart';
import '../presentation/cubits/home_page/home_page_cubit.dart';
import '../presentation/cubits/news_page/spacex_news_cubit.dart';
import '../presentation/cubits/users_page/users_page_cubit.dart';
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
      providers: [
        ChangeNotifierProvider(
            create: ((_) => AppThemeProvider()..initialize())),
        ChangeNotifierProvider(create: ((_) => LocaleProvider()..initialize())),
        BlocProvider(
            create: (context) => HomePageCubit(
                GetUpcomingLaunchesUseCase(ApiRepositoryImpl(widget.apiClient)),
                GetAllEventsUseCase(ApiRepositoryImpl(widget.apiClient)),
                FetchArticlesUseCase(
                    ArticleRepositoryImpl(widget.newsApiClient)))),
        BlocProvider(
          create: (context) => LaunchesPageCubit(
              GetAllLaunchesUseCase(ApiRepositoryImpl(widget.apiClient))),
        ),
        BlocProvider(
          create: (context) => LaunchDetailsPageCubit(
              GetLaunchDetailsUseCase(ApiRepositoryImpl(widget.apiClient))),
        ),
        BlocProvider(
          create: (context) => UpcomingLaunchesCubit(
              GetUpcomingLaunchesUseCase(ApiRepositoryImpl(widget.apiClient))),
        ),
        BlocProvider(
            create: (context) => FriendsPageCubit(
                FetchFriendsUseCase(FirestoreUserRepository()))),
        BlocProvider(
          create: (context) => NewsCubit(
            fetchRecentArticlesUseCase: FetchArticlesUseCase(
                ArticleRepositoryImpl(widget.newsApiClient)),
          ),
        ),
        BlocProvider(
          create: (context) => NasaNewsCubit(
            fetchNasaArticlesUseCase: FetchNasaArticlesUseCase(
                ArticleRepositoryImpl(widget.newsApiClient)),
          ),
        ),
        BlocProvider(
            create: (context) => SpaceXNewsCubit(
                  fetchSpaceXArticlesUseCase: FetchSpaceXArticlesUseCase(
                      ArticleRepositoryImpl(widget.newsApiClient)),
                )),
        BlocProvider(
          create: (context) => BlogsCubit(
              fetchBlogsUseCase: FetchBlogsUseCase(
                  ArticleRepositoryImpl(widget.newsApiClient))),
        ),
        BlocProvider(
            create: (context) => EventsPageCubit(
                  GetAllEventsUseCase(ApiRepositoryImpl(widget.apiClient)),
                )),
        BlocProvider(create: (context) => UsersPageCubit()),
        BlocProvider(create: (context) {
          String userId = '';

          if (widget.authenticationCubit.state is Authenticated) {
            userId =
                (widget.authenticationCubit.state as Authenticated).user.uid;
          }
          return FavoriteLaunchesPageCubit(
              fetchFavouriteLaunchesUseCase: FetchFavouriteLaunchesUseCase(
                firestore: FirebaseFirestore.instance,
                userId: userId,
                dtoToEntityConverter: LaunchDtoToEntityConverter(),
              ),
              setFavouriteLaunchUseCase: SetFavouriteLaunchUseCase(
                firestore: FirebaseFirestore.instance,
                userId: userId,
                entityToDtoConverter: LaunchEntityToDtoConverter(),
              ),
              removeFavouriteLaunchUseCase: RemoveFavouriteLaunchUseCase(
                firestore: FirebaseFirestore.instance,
              ),
              currentUserUid: userId);
        }),
        BlocProvider.value(value: widget.authenticationCubit),
      ],
      child: Consumer2<AppThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) {
          return MaterialApp.router(
              scaffoldMessengerKey: Application._scaffoldMessengerKey,
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              themeMode: themeProvider.themeMode,
              locale: Locale(localeProvider.currentLocale),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: widget.appRouter.config(),
              builder: (context, child) {
                return ScrollConfiguration(
                  behavior: const ScrollBehaviorModified(),
                  child: child!,
                );
              });
        },
      ),
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}

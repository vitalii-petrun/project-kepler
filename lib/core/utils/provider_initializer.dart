import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/global.dart';

import 'package:project_kepler/data/data%20sources/remote/api_client.dart';
import 'package:project_kepler/data/repositories/space_devs_repository_impl.dart';
import 'package:project_kepler/data/repositories/article_repository_impl.dart';
import 'package:project_kepler/data/repositories/chat_repository_impl.dart';
import 'package:project_kepler/data/repositories/firestore_user_repository.dart';
import 'package:project_kepler/domain/converters/agency_converter.dart';
import 'package:project_kepler/domain/converters/article_converter.dart';
import 'package:project_kepler/domain/converters/event_converter.dart';
import 'package:project_kepler/domain/converters/launch_converter.dart';
import 'package:project_kepler/domain/use_cases/fetch_articles_use_case.dart';
import 'package:project_kepler/domain/use_cases/fetch_blogs_use_case.dart';
import 'package:project_kepler/domain/use_cases/fetch_favourite_events_use_case.dart';
import 'package:project_kepler/domain/use_cases/fetch_favourite_launches_use_case.dart';
import 'package:project_kepler/domain/use_cases/fetch_friends_use_case.dart';
import 'package:project_kepler/domain/use_cases/fetch_nasa_articles_use_case.dart';
import 'package:project_kepler/domain/use_cases/fetch_spacex_articles_use_case.dart';
import 'package:project_kepler/domain/use_cases/generate_chat_response_use_case.dart';
import 'package:project_kepler/domain/use_cases/get_all_events_use_case.dart';
import 'package:project_kepler/domain/use_cases/get_all_launches_use_case.dart';
import 'package:project_kepler/domain/use_cases/get_launch_details_use_case.dart';
import 'package:project_kepler/domain/use_cases/get_upcoming_launches_use_case.dart';
import 'package:project_kepler/domain/use_cases/remove_favourite_event_use_case.dart';
import 'package:project_kepler/domain/use_cases/remove_favourite_launch_use_case.dart';
import 'package:project_kepler/domain/use_cases/set_favourite_event_use_case.dart';
import 'package:project_kepler/domain/use_cases/set_favourite_launch_use_case.dart';
import 'package:project_kepler/l10n/locale_provider.dart';
import 'package:project_kepler/presentation/cubits/ai_chat_page/ai_chat_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/cubits/events_page/events_cubit.dart';
import 'package:project_kepler/presentation/cubits/favourites_page/favourite_events_cubit.dart';
import 'package:project_kepler/presentation/cubits/favourites_page/favourite_launches_cubit.dart';
import 'package:project_kepler/presentation/cubits/friends_page/friends_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/launch_details/launch_details_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/launches/launches_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/launches/upcoming_launches_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/blogs_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/nasa_news_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/spacex_news_cubit.dart';
import 'package:project_kepler/presentation/cubits/users_page/users_page_cubit.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:project_kepler/presentation/themes/refresh_rate_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderInitializer {
  /// Service Locator.
  static List<SingleChildWidget> initializeProviders(ApiClient apiClient,
      ApiClient newsApiClient, AuthenticationCubit authenticationCubit) {
    return [
      ChangeNotifierProvider(create: ((_) => AppThemeProvider()..initialize())),
      ChangeNotifierProvider(create: ((_) => LocaleProvider()..initialize())),
      BlocProvider(
        create: (context) => LaunchesPageCubit(GetAllLaunchesUseCase(
            SpaceDevsRepositoryImpl(apiClient, LaunchDtoToEntityConverter(),
                EventDtoToEntityConverter(), AgencyDtoToEntityConverter()),
            languageDetectionService)),
      ),
      BlocProvider(
        create: (context) => LaunchDetailsPageCubit(GetLaunchDetailsUseCase(
            SpaceDevsRepositoryImpl(apiClient, LaunchDtoToEntityConverter(),
                EventDtoToEntityConverter(), AgencyDtoToEntityConverter()),
            languageDetectionService)),
      ),
      BlocProvider(
        create: (context) => UpcomingLaunchesCubit(GetUpcomingLaunchesUseCase(
            SpaceDevsRepositoryImpl(apiClient, LaunchDtoToEntityConverter(),
                EventDtoToEntityConverter(), AgencyDtoToEntityConverter()))),
      ),
      BlocProvider(
          create: (context) =>
              FriendsPageCubit(FetchFriendsUseCase(FirestoreUserRepository()))),
      BlocProvider(
        create: (context) => NewsCubit(
            fetchRecentArticlesUseCase: FetchArticlesUseCase(
                ArticleRepositoryImpl(
                    newsApiClient, ArticleDtoToEntityConverter()),
                languageDetectionService)),
      ),
      BlocProvider(
        create: (context) => NasaNewsCubit(
          fetchNasaArticlesUseCase: FetchNasaArticlesUseCase(
              ArticleRepositoryImpl(
                  newsApiClient, ArticleDtoToEntityConverter()),
              languageDetectionService),
        ),
      ),
      BlocProvider(
          create: (context) => SpaceXNewsCubit(
                fetchSpaceXArticlesUseCase: FetchSpaceXArticlesUseCase(
                    ArticleRepositoryImpl(
                        newsApiClient, ArticleDtoToEntityConverter()),
                    languageDetectionService),
              )),
      BlocProvider(
        create: (context) => BlogsCubit(
            fetchBlogsUseCase: FetchBlogsUseCase(
                ArticleRepositoryImpl(
                    newsApiClient, ArticleDtoToEntityConverter()),
                languageDetectionService)),
      ),
      BlocProvider(
          create: (context) => EventsCubit(
                GetAllEventsUseCase(
                    SpaceDevsRepositoryImpl(
                        apiClient,
                        LaunchDtoToEntityConverter(),
                        EventDtoToEntityConverter(),
                        AgencyDtoToEntityConverter()),
                    languageDetectionService),
              )),
      BlocProvider(create: (context) => UsersPageCubit()),
      BlocProvider(
        create: (context) => ChatCubit(GenerateChatResponseUseCase(
          ChatRepositoryImpl(),
        )),
      ),
      BlocProvider(create: (context) {
        return FavoriteLaunchesCubit(
          fetchFavouriteLaunchesUseCase: FetchFavouriteLaunchesUseCase(
            firestore: FirebaseFirestore.instance,
            apiRepository: SpaceDevsRepositoryImpl(
                apiClient,
                LaunchDtoToEntityConverter(),
                EventDtoToEntityConverter(),
                AgencyDtoToEntityConverter()),
            languageDetectionService: languageDetectionService,
          ),
          setFavouriteLaunchUseCase: SetFavouriteLaunchUseCase(
            firestore: FirebaseFirestore.instance,
            entityToDtoConverter: LaunchEntityToDtoConverter(),
          ),
          removeFavouriteLaunchUseCase: RemoveFavouriteLaunchUseCase(
            firestore: FirebaseFirestore.instance,
          ),
          authenticationCubit: authenticationCubit,
        );
      }),
      BlocProvider(create: (context) {
        return FavouriteEventsCubit(
          fetchFavouriteEventsUseCase: FetchFavouriteEventsUseCase(
            firestore: FirebaseFirestore.instance,
            apiRepository: SpaceDevsRepositoryImpl(
                apiClient,
                LaunchDtoToEntityConverter(),
                EventDtoToEntityConverter(),
                AgencyDtoToEntityConverter()),
            languageDetectionService: languageDetectionService,
          ),
          setFavouriteEventUseCase: SetFavouriteEventUseCase(
            firestore: FirebaseFirestore.instance,
          ),
          removeFavouriteEventUseCase: RemoveFavouriteEventUseCase(
            firestore: FirebaseFirestore.instance,
          ),
          authenticationCubit: authenticationCubit,
        );
      }),
      BlocProvider.value(value: authenticationCubit),
      ChangeNotifierProvider(create: (_) => RefreshRateProvider()),
    ];
  }
}

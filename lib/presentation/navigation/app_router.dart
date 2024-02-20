import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/presentation/pages/launches_page.dart';

import '../../domain/entities/event.dart';
import '../pages/ai_chat_page.dart';
import '../pages/core_page.dart';
import '../pages/events_details_page.dart';
import '../pages/events_page.dart';
import '../pages/friends_page.dart';
import '../pages/home_page.dart';
import '../pages/launch_details_page.dart';
import '../pages/login_page.dart';
import '../pages/news_page.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';
import '../pages/favourite_launches_page.dart';

import '../pages/users_page.dart';

part 'app_router.gr.dart';

@RoutePage(name: 'EmptyRouterPage')
class EmptyPage extends AutoRouter {
  const EmptyPage({super.key});
}

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: CoreRoute.page,
      path: '/',
      children: [
        AutoRoute(path: '', page: HomeRoute.page),
        AutoRoute(page: SettingsRoute.page, path: 'settings'),
        AutoRoute(page: FavouriteLaunchesRoute.page, path: 'favourites'),
        AutoRoute(page: LaunchesRoute.page, path: 'launches'),
      ],
    ),
    AutoRoute(page: LaunchDetailsRoute.page, path: '/launch_details/:launchId'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: ProfileRoute.page, path: '/profile'),
    AutoRoute(page: FriendsRoute.page, path: '/friends'),
    AutoRoute(page: NewsRoute.page, path: '/news'),
    AutoRoute(page: UsersRoute.page, path: '/users'),
    AutoRoute(page: AIChatRoute.page, path: '/ai_chat'),
    AutoRoute(page: EventsRoute.page, path: '/events'),
    AutoRoute(page: EventsDetailsRoute.page, path: '/events_details/:eventId'),
  ];
}

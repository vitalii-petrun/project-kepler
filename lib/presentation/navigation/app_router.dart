import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/launch_details_page.dart';
import '../pages/login_page.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: EmptyRouterPage.page,
      path: '/',
      children: [
        AutoRoute(path: '', page: HomeRoute.page),
        AutoRoute(
            path: 'launch_details/:launchId', page: LaunchDetailsRoute.page),
      ],
    ),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
    AutoRoute(page: ProfileRoute.page, path: '/profile'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
  ];
}

@RoutePage(name: 'EmptyRouterPage')
class EmptyPage extends AutoRouter {
  const EmptyPage({super.key});
}

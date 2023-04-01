import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/launch_details_page.dart';
import '../pages/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    /*  AutoRoute(page: HomeRoute.page, path: "/", children: [
      AutoRoute(path: 'launch/:launchId', page: LaunchDetailsRoute.page),
    ]), */
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
  ];
}

@RoutePage(name: 'EmptyRouterPage')
class EmptyPage extends AutoRouter {
  const EmptyPage({super.key});
}
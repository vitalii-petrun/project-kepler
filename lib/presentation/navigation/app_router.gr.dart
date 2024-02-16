// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    EmptyRouterPage.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EmptyPage(),
      );
    },
    CoreRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CorePage(),
      );
    },
    FavouriteLaunchesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavouriteLaunchesPage(),
      );
    },
    FriendsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FriendsPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    LaunchesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LaunchesPage(),
      );
    },
    LaunchDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<LaunchDetailsRouteArgs>(
          orElse: () => LaunchDetailsRouteArgs(
              launchId: pathParams.getString('launchId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LaunchDetailsPage(
          key: args.key,
          launchId: args.launchId,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    NewsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewsPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    UsersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UsersPage(),
      );
    },
    AIChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AIChatPage(),
      );
    },
  };
}

/// generated route for
/// [EmptyPage]
class EmptyRouterPage extends PageRouteInfo<void> {
  const EmptyRouterPage({List<PageRouteInfo>? children})
      : super(
          EmptyRouterPage.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRouterPage';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CorePage]
class CoreRoute extends PageRouteInfo<void> {
  const CoreRoute({List<PageRouteInfo>? children})
      : super(
          CoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'CoreRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavouriteLaunchesPage]
class FavouriteLaunchesRoute extends PageRouteInfo<void> {
  const FavouriteLaunchesRoute({List<PageRouteInfo>? children})
      : super(
          FavouriteLaunchesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavouriteLaunchesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FriendsPage]
class FriendsRoute extends PageRouteInfo<void> {
  const FriendsRoute({List<PageRouteInfo>? children})
      : super(
          FriendsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FriendsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LaunchesPage]
class LaunchesRoute extends PageRouteInfo<void> {
  const LaunchesRoute({List<PageRouteInfo>? children})
      : super(
          LaunchesRoute.name,
          initialChildren: children,
        );

  static const String name = 'LaunchesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LaunchDetailsPage]
class LaunchDetailsRoute extends PageRouteInfo<LaunchDetailsRouteArgs> {
  LaunchDetailsRoute({
    Key? key,
    required String launchId,
    List<PageRouteInfo>? children,
  }) : super(
          LaunchDetailsRoute.name,
          args: LaunchDetailsRouteArgs(
            key: key,
            launchId: launchId,
          ),
          rawPathParams: {'launchId': launchId},
          initialChildren: children,
        );

  static const String name = 'LaunchDetailsRoute';

  static const PageInfo<LaunchDetailsRouteArgs> page =
      PageInfo<LaunchDetailsRouteArgs>(name);
}

class LaunchDetailsRouteArgs {
  const LaunchDetailsRouteArgs({
    this.key,
    required this.launchId,
  });

  final Key? key;

  final String launchId;

  @override
  String toString() {
    return 'LaunchDetailsRouteArgs{key: $key, launchId: $launchId}';
  }
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewsPage]
class NewsRoute extends PageRouteInfo<void> {
  const NewsRoute({List<PageRouteInfo>? children})
      : super(
          NewsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UsersPage]
class UsersRoute extends PageRouteInfo<void> {
  const UsersRoute({List<PageRouteInfo>? children})
      : super(
          UsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AIChatPage]
class AIChatRoute extends PageRouteInfo<void> {
  const AIChatRoute({List<PageRouteInfo>? children})
      : super(
          AIChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'AIChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

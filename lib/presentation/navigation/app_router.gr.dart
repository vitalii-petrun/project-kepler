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
    AIChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AIChatPage(),
      );
    },
    CoreRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CorePage(),
      );
    },
    EmptyRouterPage.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EmptyPage(),
      );
    },
    EventsDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<EventsDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EventsDetailsPage(
          key: args.key,
          event: args.event,
          eventId: args.eventId,
        ),
      );
    },
    EventsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EventsPage(),
      );
    },
    FavouritesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavouritesPage(),
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
    LaunchDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<LaunchDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LaunchDetailsPage(
          key: args.key,
          launchId: args.launchId,
          launch: args.launch,
        ),
      );
    },
    LaunchesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LaunchesPage(),
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
  };
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
/// [EventsDetailsPage]
class EventsDetailsRoute extends PageRouteInfo<EventsDetailsRouteArgs> {
  EventsDetailsRoute({
    Key? key,
    required Event event,
    required int eventId,
    List<PageRouteInfo>? children,
  }) : super(
          EventsDetailsRoute.name,
          args: EventsDetailsRouteArgs(
            key: key,
            event: event,
            eventId: eventId,
          ),
          rawPathParams: {'eventId': eventId},
          initialChildren: children,
        );

  static const String name = 'EventsDetailsRoute';

  static const PageInfo<EventsDetailsRouteArgs> page =
      PageInfo<EventsDetailsRouteArgs>(name);
}

class EventsDetailsRouteArgs {
  const EventsDetailsRouteArgs({
    this.key,
    required this.event,
    required this.eventId,
  });

  final Key? key;

  final Event event;

  final int eventId;

  @override
  String toString() {
    return 'EventsDetailsRouteArgs{key: $key, event: $event, eventId: $eventId}';
  }
}

/// generated route for
/// [EventsPage]
class EventsRoute extends PageRouteInfo<void> {
  const EventsRoute({List<PageRouteInfo>? children})
      : super(
          EventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavouritesPage]
class FavouritesRoute extends PageRouteInfo<void> {
  const FavouritesRoute({List<PageRouteInfo>? children})
      : super(
          FavouritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavouritesRoute';

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
/// [LaunchDetailsPage]
class LaunchDetailsRoute extends PageRouteInfo<LaunchDetailsRouteArgs> {
  LaunchDetailsRoute({
    Key? key,
    required String launchId,
    required Launch launch,
    List<PageRouteInfo>? children,
  }) : super(
          LaunchDetailsRoute.name,
          args: LaunchDetailsRouteArgs(
            key: key,
            launchId: launchId,
            launch: launch,
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
    required this.launch,
  });

  final Key? key;

  final String launchId;

  final Launch launch;

  @override
  String toString() {
    return 'LaunchDetailsRouteArgs{key: $key, launchId: $launchId, launch: $launch}';
  }
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

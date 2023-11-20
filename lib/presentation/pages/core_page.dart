import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/presentation/widgets/app_nav_bar.dart';

import '../navigation/app_router.dart';

@RoutePage()
class CorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        LaunchesRoute(),
        SettingsRoute(),
        FavouriteLaunchesRoute()
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return const AppNavigationBar();
      },
    );
  }
}

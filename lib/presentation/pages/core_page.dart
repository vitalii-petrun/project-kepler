import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/presentation/widgets/app_navigation/app_nav_bar.dart';
import 'package:provider/provider.dart';

import '../navigation/app_router.dart';

@RoutePage()
class CorePage extends StatelessWidget {
  const CorePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        LaunchesRoute(),
        SettingsRoute(),
        FavouriteLaunchesRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return const AppNavigationBar();
      },
    );
  }
}

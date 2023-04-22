import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

import '../blocs/favourite_launches_page/favourite_launches_page_cubit.dart';
import '../blocs/favourite_launches_page/favourite_launches_page_state.dart';
import '../widgets/launch_card.dart';

@RoutePage()
class FavouriteLaunchesPage extends StatelessWidget {
  const FavouriteLaunchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.favourite),
      ),
      body: BlocBuilder<FavoriteLaunchesPageCubit, FavouriteLaunchesPageState>(
        builder: (context, state) {
          if (state is FavouriteLaunchesInit) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavouriteLaunchesLoaded) {
            return ListView.builder(
              itemCount: state.launches.length,
              itemBuilder: (context, index) {
                return LaunchCard(
                  launch: state.launches[index],
                );
              },
            );
          } else if (state is FavouriteLaunchesError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

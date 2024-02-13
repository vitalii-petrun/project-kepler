import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

import '../../domain/entities/launch.dart';
import '../cubits/favourite_launches_page/favourite_launches_page_cubit.dart';
import '../cubits/favourite_launches_page/favourite_launches_page_state.dart';
import '../widgets/launch_card.dart';
import '../widgets/no_internet.dart';

@RoutePage()
class FavouriteLaunchesPage extends StatefulWidget {
  const FavouriteLaunchesPage({Key? key}) : super(key: key);

  @override
  State<FavouriteLaunchesPage> createState() => _FavouriteLaunchesPageState();
}

class _FavouriteLaunchesPageState extends State<FavouriteLaunchesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteLaunchesPageCubit>().fetchFavouriteLaunches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.favourite)),
      body: BlocBuilder<FavoriteLaunchesPageCubit, FavouriteLaunchesPageState>(
        builder: (context, state) {
          if (state is FavouriteLaunchesInit) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouriteLaunchesLoaded) {
            return _LoadedBody(launches: state.launches);
          } else if (state is FavouriteLaunchesError) {
            return const _FailedBody();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  final List<Launch> launches;

  const _LoadedBody({
    required this.launches,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FavoriteLaunchesPageCubit>().fetchFavouriteLaunches();
      },
      child: ListView.builder(
        itemCount: launches.length,
        itemBuilder: (context, index) {
          return LaunchCard(
            launch: launches[index],
          );
        },
      ),
    );
  }
}

class _FailedBody extends StatelessWidget {
  const _FailedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FavoriteLaunchesPageCubit>().fetchFavouriteLaunches();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
                height: constraints.maxHeight,
                child: const Center(child: NoInternet())),
          );
        },
      ),
    );
  }
}

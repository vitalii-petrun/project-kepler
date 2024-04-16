import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

import '../../domain/entities/launch.dart';
import '../cubits/favourites_page/favourite_launches_cubit.dart';
import '../cubits/favourites_page/favourite_launches_state.dart';
import '../widgets/launch_card.dart';
import '../widgets/no_favourite.dart';
import '../widgets/no_internet.dart';
import '../widgets/rounded_app_bar.dart';

@RoutePage()
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteLaunchesCubit>().fetchFavouriteLaunches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: RoundedAppBar(title: Text(context.l10n.favourite)),
      body: BlocBuilder<FavoriteLaunchesCubit, FavouriteLaunchesState>(
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
    if (launches.isEmpty) {
      return const NoFavourite();
    }
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<FavoriteLaunchesCubit>().fetchFavouriteLaunches();
        },
        child: ListView.builder(
          itemCount: launches.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: LaunchCard(
                launch: launches[index],
              ),
            );
          },
        ),
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
        context.read<FavoriteLaunchesCubit>().fetchFavouriteLaunches();
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

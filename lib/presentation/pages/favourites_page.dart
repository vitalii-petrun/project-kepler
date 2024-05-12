import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';

import 'package:project_kepler/presentation/cubits/favourites_page/favourite_events_cubit.dart';
import 'package:project_kepler/presentation/cubits/favourites_page/favourite_events_state.dart';
import 'package:project_kepler/presentation/utils/ui_helpers.dart';
import 'package:project_kepler/presentation/widgets/event_card.dart';
import 'package:project_kepler/presentation/widgets/login_button.dart';
import 'package:project_kepler/presentation/widgets/space_tab_bar.dart';

import '../cubits/favourites_page/favourite_launches_cubit.dart';
import '../cubits/favourites_page/favourite_launches_state.dart';
import '../widgets/launch_card.dart';

@RoutePage()
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);
  @override
  FavouritesPageState createState() => FavouritesPageState();
}

class FavouritesPageState extends State<FavouritesPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.favs),
      ),
      body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is! Authenticated) {
            return _buildAuthenticationPrompt(context);
          }
          return Column(
            children: [
              SpaceTabBar(
                controller: _tabController,
                tabs: [
                  Tab(child: SpaceTabBarItem(label: context.l10n.events)),
                  Tab(child: SpaceTabBarItem(label: context.l10n.launches)),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildEventsTab(),
                    _buildLaunchesTab(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAuthenticationPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '🔓 ${context.l10n.unlockFavs}',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: AppColors.senaryColor,
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Text(
              context.l10n.loginPromptFav,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(height: 30),
          Container(
              constraints: const BoxConstraints(maxWidth: 300),
              width: double.infinity,
              child: const LoginButton()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEventsTab() {
    return BlocBuilder<FavouriteEventsCubit, FavouriteEventsState>(
      builder: (context, state) {
        if (state is FavouriteEventsLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<FavouriteEventsCubit>().fetchFavouriteEvents();
            },
            child: ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: EventCard(
                      event: state.events[index],
                      eventId: state.events[index].id),
                );
              },
            ),
          );
        } else if (state is FavouriteEventsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildLaunchesTab() {
    return BlocBuilder<FavoriteLaunchesCubit, FavouriteLaunchesState>(
      builder: (context, state) {
        if (state is FavouriteLaunchesLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<FavoriteLaunchesCubit>().fetchFavouriteLaunches();
            },
            child: ListView.builder(
              itemCount: state.launches.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: LaunchCard(launch: state.launches[index]),
                );
              },
            ),
          );
        } else if (state is FavouriteLaunchesError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

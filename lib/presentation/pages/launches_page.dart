import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/cubits/launches/launches_page_state.dart';
import 'package:project_kepler/presentation/cubits/launches/upcoming_launches_page_cubit.dart';
import 'package:project_kepler/presentation/widgets/no_internet.dart';
import '../../core/utils/shimmer_gradients.dart';
import '../../domain/entities/launch.dart';
import '../cubits/authentication/authentication_cubit.dart';
import '../cubits/launches/launches_page_cubit.dart';

import '../widgets/launch_card.dart';

import '../widgets/shimmer.dart';
import '../widgets/shimmer_loading_body.dart';
import '../widgets/space_drawer.dart';
import '../widgets/space_tab_bar.dart';

@RoutePage()
class LaunchesPage extends StatefulWidget {
  const LaunchesPage({Key? key}) : super(key: key);

  @override
  State<LaunchesPage> createState() => _LaunchesPageState();
}

class _LaunchesPageState extends State<LaunchesPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<LaunchesPageCubit>().fetch();
    context.read<UpcomingLaunchesCubit>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.theme.brightness == Brightness.dark;
    final tabController = TabController(length: 2, vsync: this);

    final LinearGradient gradient =
        isDarkTheme ? nightShimmerGradient : dayShimmerGradient;

    return Shimmer(
      linearGradient: gradient,
      child: Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.launches),
            elevation: 0,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  if (context.read<AuthenticationCubit>().state
                      is Authenticated) {
                    context.router.pushNamed('/profile');
                  } else {
                    context.router.pushNamed('/login');
                  }
                },
              ),
            ],
          ),
          drawer: const SpaceDrawer(),
          body: Column(
            children: [
              SpaceTabBar(
                controller: tabController,
                tabs: [
                  Tab(text: context.l10n.recent),
                  Tab(text: context.l10n.upcoming),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    BlocBuilder<LaunchesPageCubit, LaunchesPageState>(
                      builder: (context, state) {
                        if (state is LaunchesLoaded) {
                          return _LoadedBody(
                              onRefresh: () async =>
                                  context.read<LaunchesPageCubit>().fetch(),
                              launches: state.launches);
                        } else if (state is LaunchesError) {
                          return const _FailedBody();
                        } else {
                          return const ShimmerLoadingBody();
                        }
                      },
                    ),
                    BlocBuilder<UpcomingLaunchesCubit, LaunchesPageState>(
                      builder: (context, state) {
                        if (state is LaunchesLoaded) {
                          return _LoadedBody(
                              onRefresh: () async =>
                                  context.read<UpcomingLaunchesCubit>().fetch(),
                              launches: state.launches);
                        } else if (state is LaunchesError) {
                          return const _FailedBody();
                        } else {
                          return const ShimmerLoadingBody();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class _LoadedBody extends StatefulWidget {
  final List<Launch> launches;
  final VoidCallback onRefresh;

  const _LoadedBody({
    required this.launches,
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  State<_LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<_LoadedBody>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => widget.onRefresh(),
      child: ListView.separated(
          itemCount: widget.launches.length,
          itemBuilder: (context, index) {
            final launch = widget.launches[index];
            return LaunchCard(launch: launch);
          },
          separatorBuilder: (_, __) => const SizedBox(height: 20)),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _FailedBody extends StatelessWidget {
  const _FailedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async => context.read<LaunchesPageCubit>().fetch(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
                height: constraints.maxHeight,
                child: const Center(child: NoInternet())),
          ),
        );
      },
    );
  }
}

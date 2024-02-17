import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/cubits/launches/launches_page_state.dart';
import 'package:project_kepler/presentation/widgets/no_internet.dart';
import '../../core/utils/shimmer_gradients.dart';
import '../../domain/entities/launch.dart';
import '../cubits/authentication/authentication_cubit.dart';
import '../cubits/launches/launches_page_cubit.dart';
import '../widgets/launch_card.dart';
import '../widgets/rounded_app_bar.dart';
import '../widgets/shimmer.dart';
import '../widgets/shimmer_loading_body.dart';
import '../widgets/space_drawer.dart';

@RoutePage()
class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    super.initState();
    context.read<LaunchesPageCubit>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.theme.brightness == Brightness.dark;

    final LinearGradient gradient =
        isDarkTheme ? nightShimmerGradient : dayShimmerGradient;

    return Shimmer(
      linearGradient: gradient,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: RoundedAppBar(
          title: Text(context.l10n.launches),
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
        body: Container(),
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
      onRefresh: () async => context.read<LaunchesPageCubit>().fetch(),
      child: ListView.separated(
          itemCount: launches.length,
          itemBuilder: (context, index) {
            final launch = launches[index];
            return LaunchCard(launch: launch);
          },
          separatorBuilder: (_, __) => const SizedBox(height: 20)),
    );
  }
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

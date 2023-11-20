import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/blocs/home_page/home_page_cubit.dart';
import 'package:project_kepler/presentation/widgets/no_internet.dart';
import '../../domain/entities/launch.dart';
import '../blocs/authentication/authentication_cubit.dart';
import '../blocs/home_page/home_page_state.dart';
import '../widgets/launch_card.dart';
import '../widgets/shimmer.dart';
import '../widgets/shimmer_loading_body.dart';
import '../widgets/space_drawer.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.home),
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
        body: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            if (state is LaunchesLoaded) {
              return _LoadedBody(launches: state.launches);
            } else if (state is LaunchesError) {
              return const _FailedBody();
            } else {
              return ShimmerLoadingBody();
            }
          },
        ),
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
      onRefresh: () async => context.read<HomePageCubit>().fetch(),
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
          onRefresh: () async => context.read<HomePageCubit>().fetch(),
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

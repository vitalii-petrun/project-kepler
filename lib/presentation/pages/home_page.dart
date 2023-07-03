import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/blocs/home_page/home_page_cubit.dart';
import 'package:project_kepler/presentation/widgets/no_internet.dart';
import '../../domain/entities/launch.dart';
import '../blocs/authentication/authentication_cubit.dart';
import '../blocs/home_page/home_page_state.dart';
import '../widgets/filter_card.dart';
import '../widgets/launch_card.dart';
import '../widgets/space_drawer.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisibile = false;

  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.home),
        actions: [
          IconButton(
              onPressed: () => setState(() => _isVisibile = !_isVisibile),
              icon: const Icon(Icons.filter_list)),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              if (context.read<AuthenticationCubit>().state is Authenticated) {
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
            return _LoadedBody(
                launches: state.launches, isFilterVisible: _isVisibile);
          } else if (state is LaunchesError) {
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
  final bool isFilterVisible;

  const _LoadedBody({
    required this.launches,
    required this.isFilterVisible,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<HomePageCubit>().fetch(),
      child: PortalTarget(
        visible: isFilterVisible,
        portalFollower: Padding(
          padding: EdgeInsets.only(
              top: context.mediaQuery.padding.top + kToolbarHeight + 50),
          child: const FilterCard(),
        ),
        child: ListView.separated(
            itemCount: launches.length,
            itemBuilder: (context, index) {
              final launch = launches[index];
              return LaunchCard(launch: launch);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 20)),
      ),
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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/blocs/home_page/home_page_cubit.dart';
import '../blocs/authentication/authentication_cubit.dart';
import '../blocs/home_page/home_page_state.dart';
import '../widgets/launch_card.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.home),
        actions: [
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
            return RefreshIndicator(
              onRefresh: () async => context.read<HomePageCubit>().fetch(),
              child: ListView.separated(
                  itemCount: state.launches.length,
                  itemBuilder: (context, index) {
                    final launch = state.launches[index];
                    return LaunchCard(launch: launch);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 20)),
            );
          } else if (state is LaunchesError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/blocs/home_page/home_page_cubit.dart';
import '../blocs/home_page/home_page_state.dart';
import '../widgets/launch_card.dart';
import '../widgets/space_drawer.dart';

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
      appBar: AppBar(title: Text(context.l10n.home)),
      drawer: SpaceDrawer(),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is LaunchesLoaded) {
            return RefreshIndicator(
              onRefresh: () async => context.read<HomePageCubit>().fetch(),
              child: ListView.separated(
                  itemCount: state.launches.length,
                  itemBuilder: (context, index) {
                    final launch = state.launches[index];
                    return LaunchCard(
                      net: launch.net,
                      launchName: launch.name,
                      launchStatus: launch.status.name,
                      padLocation: launch.pad.location.name,
                      launchServiceProvider: launch.launchServiceProvider.name,
                      missionDescription: launch.mission?.description,
                      image: launch.image,
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 20)),
            );
          } else if (state is LaunchesError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

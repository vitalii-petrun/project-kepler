import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/blocs/launch_details/launch_details_page_cubit.dart';
import '../blocs/launch_details/launch_details_page_state.dart';
import '../widgets/space_drawer.dart';

@RoutePage()
class LaunchDetailsPage extends StatelessWidget {
  final String launchId;
  const LaunchDetailsPage({Key? key, required this.launchId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.home)),
      drawer: const SpaceDrawer(),
      body: BlocBuilder<LaunchDetailsPageCubit, LaunchDetailsPageState>(
        builder: (context, state) {
          if (state is LaunchDetailsPageStateLoaded) {
            return RefreshIndicator(
              onRefresh: () async => context
                  .read<LaunchDetailsPageCubit>()
                  .getLaunchDetails(launchId),
              child: Text(state.launch.name),
            );
          } else if (state is LaunchDetailsPageStateError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

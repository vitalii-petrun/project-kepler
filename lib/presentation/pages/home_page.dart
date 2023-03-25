import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/presentation/blocs/home_page/home_page_cubit.dart';
import '../blocs/home_page/home_page_state.dart';

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
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is LaunchesLoaded) {
            return ListView.builder(
              itemCount: state.launches.length,
              itemBuilder: (context, index) {
                final launch = state.launches[index];
                return ListTile(
                  title: Text(launch.name),
                  subtitle:
                      Text(launch.rocket.configuration.fullName.toString()),
                );
              },
            );
          } else if (state is LaunchesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

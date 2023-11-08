import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/data/repositories/api_repository_impl.dart';
import 'launches_page_state.dart';

class LaunchesPageCubit extends Cubit<LaunchesPageState> {
  final ApiRepositoryImpl repository;

  LaunchesPageCubit(this.repository) : super(LaunchesInit());
  void fetch() async {
    await repository
        .getLaunchList()
        .then((launches) => emit(LaunchesLoaded(launches)))
        .catchError((e) => emit(LaunchesError(e.toString())));
  }
}

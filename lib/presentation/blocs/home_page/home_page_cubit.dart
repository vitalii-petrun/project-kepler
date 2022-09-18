import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/data/repositories/api_repository_impl.dart';
import 'package:project_kepler/presentation/blocs/home_page/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final ApiRepositoryImpl repository;

  HomePageCubit(this.repository) : super(LaunchesInit());
  void fetch() async {
    await repository
        .getLaunchList()
        .then((launches) => emit(LaunchesLoaded(launches)));
  }
}

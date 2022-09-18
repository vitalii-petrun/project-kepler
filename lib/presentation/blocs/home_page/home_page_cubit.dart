import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/domain/repositories/api_repository.dart';
import 'package:project_kepler/presentation/blocs/home_page/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final ApiRepository repository;

  HomePageCubit(this.repository) : super(LaunchesInit());
  void fetch() async {
    await repository
        .getLaunchList()
        .then((launches) => emit(LaunchesLoaded(launches)));
  }
}

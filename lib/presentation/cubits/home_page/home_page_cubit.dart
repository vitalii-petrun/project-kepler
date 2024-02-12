import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_kepler/presentation/cubits/home_page/home_page_state.dart';

import '../../../domain/use_cases/get_upcoming_launches_use_case.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final GetUpcomingLaunchesUseCase getUpcomingLaunchesUseCase;

  HomePageCubit(this.getUpcomingLaunchesUseCase) : super(LaunchesInit());

  void fetch() async {
    emit(LaunchesLoading());
    try {
      final launches = await getUpcomingLaunchesUseCase();
      emit(LaunchesLoaded(launches));
    } catch (e) {
      emit(LaunchesError(e.toString()));
    }
  }
}

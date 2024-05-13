import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/global.dart';

import '../../../domain/use_cases/get_upcoming_launches_use_case.dart';
import 'launches_page_state.dart';

class UpcomingLaunchesCubit extends Cubit<LaunchesPageState> {
  final GetUpcomingLaunchesUseCase getUpcomingLaunchesUseCase;

  UpcomingLaunchesCubit(this.getUpcomingLaunchesUseCase)
      : super(LaunchesInit());

  Future<void> fetch() async {
    emit(LaunchesLoading());
    logger.d('Current state: $state');
    try {
      final launches = await getUpcomingLaunchesUseCase();
      emit(LaunchesLoaded(launches));
    } catch (e) {
      emit(LaunchesError(e.toString()));
    }
  }
}

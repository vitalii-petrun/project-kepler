import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_all_launches_use_case.dart';
import 'launches_page_state.dart';

class LaunchesCubit extends Cubit<LaunchesState> {
  final GetAllLaunchesUseCase getAllLaunchesUseCase;

  LaunchesCubit(this.getAllLaunchesUseCase) : super(LaunchesInit());

  void fetch() async {
    emit(LaunchesLoading());
    try {
      final launches = await getAllLaunchesUseCase();
      emit(LaunchesLoaded(launches));
    } catch (e) {
      emit(LaunchesError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'launch_details_page_state.dart';
import '../../../domain/use_cases/get_launch_details_use_case.dart';

class LaunchDetailsPageCubit extends Cubit<LaunchDetailsPageState> {
  final GetLaunchDetailsUseCase getLaunchDetailsUseCase;

  LaunchDetailsPageCubit(this.getLaunchDetailsUseCase)
      : super(LaunchDetailsPageStateInit());

  void getLaunchDetails(String id) async {
    emit(LaunchDetailsPageStateLoading());
    try {
      final result = await getLaunchDetailsUseCase(id);
      emit(LaunchDetailsPageStateLoaded(result.launch, result.agency));
    } catch (e) {
      emit(LaunchDetailsPageStateError(e.toString()));
    }
  }
}

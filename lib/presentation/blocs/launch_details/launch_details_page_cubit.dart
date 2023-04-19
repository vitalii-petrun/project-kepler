import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/api_repository_impl.dart';
import 'launch_details_page_state.dart';

class LaunchDetailsPageCubit extends Cubit<LaunchDetailsPageState> {
  LaunchDetailsPageCubit(this.repository) : super(LaunchDetailsPageStateInit());

  final ApiRepositoryImpl repository;

  void getLaunchDetails(String id) async {
    try {
      final launch = await repository.getLaunchDetailsById(id);
      final agency = await repository.getAgencyById(launch.pad.agencyID ?? 0);
      final newState = LaunchDetailsPageStateLoaded(launch, agency);
      emit(newState);
    } catch (e) {
      emit(LaunchDetailsPageStateError(e.toString()));
    }
  }
}

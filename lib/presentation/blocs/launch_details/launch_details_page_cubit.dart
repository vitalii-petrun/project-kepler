import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/api_repository_impl.dart';
import 'launch_details_page_state.dart';

class LaunchDetailsPageCubit extends Cubit<LaunchDetailsPageState> {
  LaunchDetailsPageCubit(this.repository) : super(LaunchDetailsPageStateInit());

  final ApiRepositoryImpl repository;

  void getLaunchDetails(String id) async {
    await repository
        .getLaunchDetails(id)
        .then((launch) => emit(LaunchDetailsPageStateLoaded(launch)))
        .catchError((e) => emit(LaunchDetailsPageStateError(e.toString())));
  }
}

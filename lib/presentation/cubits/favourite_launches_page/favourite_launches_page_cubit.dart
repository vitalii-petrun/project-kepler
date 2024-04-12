import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';

import '../../../domain/entities/launch.dart';
import '../../../domain/use_cases/fetch_favourite_launches_use_case.dart';
import '../../../domain/use_cases/remove_favourite_launch_use_case.dart';
import '../../../domain/use_cases/set_favourite_launch_use_case.dart';
import 'favourite_launches_page_state.dart';

class FavoriteLaunchesPageCubit extends Cubit<FavouriteLaunchesPageState> {
  final FetchFavouriteLaunchesUseCase fetchFavouriteLaunchesUseCase;
  final SetFavouriteLaunchUseCase setFavouriteLaunchUseCase;
  final RemoveFavouriteLaunchUseCase removeFavouriteLaunchUseCase;
  final AuthenticationCubit authenticationCubit;

  FavoriteLaunchesPageCubit({
    required this.fetchFavouriteLaunchesUseCase,
    required this.setFavouriteLaunchUseCase,
    required this.removeFavouriteLaunchUseCase,
    required this.authenticationCubit,
  }) : super(FavouriteLaunchesInit()) {
    setUserId();
    fetchFavouriteLaunches();
  }

  void setUserId() {
    final userId = authenticationCubit.getUid();
    logger.d('User id: $userId');
    setFavouriteLaunchUseCase.userId = userId;
    fetchFavouriteLaunchesUseCase.userId = userId;
    removeFavouriteLaunchUseCase.userId = userId;
  }

  void clearUserId() {
    setFavouriteLaunchUseCase.userId = null;
    removeFavouriteLaunchUseCase.userId = null;
    fetchFavouriteLaunchesUseCase.userId = null;
  }

  void fetchFavouriteLaunches() async {
    try {
      final launches = await fetchFavouriteLaunchesUseCase();
      emit(FavouriteLaunchesLoaded(launches));
    } catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    }
  }

  void setFavouriteLaunch(Launch launch) async {
    try {
      await setFavouriteLaunchUseCase(launch);
      fetchFavouriteLaunches();
    } catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    }
  }

  void removeFavouriteLaunch(String launchId) async {
    try {
      await removeFavouriteLaunchUseCase(launchId);
      fetchFavouriteLaunches();
    } catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    }
  }
}

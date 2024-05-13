import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';

import '../../../domain/entities/launch.dart';
import '../../../domain/use_cases/fetch_favourite_launches_use_case.dart';
import '../../../domain/use_cases/remove_favourite_launch_use_case.dart';
import '../../../domain/use_cases/set_favourite_launch_use_case.dart';
import 'favourite_launches_state.dart';

class FavoriteLaunchesCubit extends Cubit<FavouriteLaunchesState> {
  final FetchFavouriteLaunchesUseCase fetchFavouriteLaunchesUseCase;
  final SetFavouriteLaunchUseCase setFavouriteLaunchUseCase;
  final RemoveFavouriteLaunchUseCase removeFavouriteLaunchUseCase;
  final AuthenticationCubit authenticationCubit;

  FavoriteLaunchesCubit({
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

  void toggleFavouriteLaunch(Launch launch) {
    logger.d('Toggling favourite launch: ${launch.id}');
    var currentState = state;
    if (currentState is FavouriteLaunchesLoaded) {
      var currentLaunches = List<Launch>.from(currentState.launches);
      bool isFavourite = currentLaunches.any((e) => e.id == launch.id);

      // Update the state optimistically
      if (isFavourite) {
        currentLaunches.removeWhere((e) => e.id == launch.id);
      } else {
        currentLaunches.add(launch);
      }
      emit(FavouriteLaunchesLoaded(currentLaunches));

      // Perform the actual update asynchronously
      if (isFavourite) {
        removeFavouriteLaunch(launch.id);
      } else {
        setFavouriteLaunch(launch);
      }
    }
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
    } catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    }
  }

  void removeFavouriteLaunch(String launchId) async {
    try {
      await removeFavouriteLaunchUseCase(launchId);
    } catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    }
  }

  bool checkIfFavourite(Launch launch) {
    var currentState = state;
    if (currentState is FavouriteLaunchesLoaded) {
      var currentLaunches = List<Launch>.from(currentState.launches);
      bool isFavourite = currentLaunches.any((e) => e.id == launch.id);
      return isFavourite;
    }
    return false;
  }
}

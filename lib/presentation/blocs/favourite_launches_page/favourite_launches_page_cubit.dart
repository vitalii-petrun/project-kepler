import 'package:flutter_bloc/flutter_bloc.dart';
import 'favourite_launches_page_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteLaunchesPageCubit extends Cubit<FavouriteLaunchesPageState> {
  final SharedPreferences storage;

  FavoriteLaunchesPageCubit(this.storage) : super(FavouriteLaunchesInit());

  void fetch() async {
    return emit(FavouriteLaunchesLoaded([]));
  }
}

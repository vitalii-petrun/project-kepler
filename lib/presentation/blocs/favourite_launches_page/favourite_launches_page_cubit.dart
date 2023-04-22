import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/launch.dart';
import 'favourite_launches_page_state.dart';

class FavoriteLaunchesPageCubit extends Cubit<FavouriteLaunchesPageState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FavoriteLaunchesPageCubit() : super(FavouriteLaunchesInit()) {
    fetchFavouriteLaunches();
  }

  void fetchFavouriteLaunches() async {
    try {
      final snapshot = await firestore.collection('launches').get();
      final launches =
          snapshot.docs.map((e) => Launch.fromJson(e.data())).toList();

      emit(FavouriteLaunchesLoaded(launches));
    } catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    }
  }

  void setFavouriteLaunch(Launch launch) async {
    try {
      await firestore
          .collection('launches')
          .doc(launch.id)
          .set(launch.toJson());
    } catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    }
  }
}

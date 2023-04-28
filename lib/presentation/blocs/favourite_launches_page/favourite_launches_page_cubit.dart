import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/launch.dart';
import 'favourite_launches_page_state.dart';

class FavoriteLaunchesPageCubit extends Cubit<FavouriteLaunchesPageState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FavoriteLaunchesPageCubit() : super(FavouriteLaunchesInit()) {
    fetchFavouriteLaunches();
  }

  void fetchFavouriteLaunches() async {
    try {
      final snapshot = await _firestore.collection('launches').get();
      final launches =
          snapshot.docs.map((e) => Launch.fromJson(e.data())).toList();
      emit(FavouriteLaunchesLoaded(launches));
    } on FirebaseException catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    } on SocketException catch (e) {
      emit(FavouriteLaunchesError('Network error: ${e.toString()}'));
    } catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    }
  }

  void setFavouriteLaunch(Launch launch) async {
    try {
      await _firestore
          .collection('launches')
          .doc(launch.id)
          .set(launch.toJson());

      emit(
        FavouriteLaunchesLoaded(
          (state as FavouriteLaunchesLoaded).launches..add(launch),
        ),
      );
    } catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    }
  }

  void removeFavouriteLaunch(Launch launch) async {
    try {
      await _firestore.collection('launches').doc(launch.id).delete();

      final newLaunches = (state as FavouriteLaunchesLoaded)
          .launches
          .where((element) => element.id != launch.id)
          .toList();

      emit(FavouriteLaunchesLoaded(newLaunches));
    } catch (e) {
      emit(FavouriteLaunchesError(e.toString()));
    }
  }
}

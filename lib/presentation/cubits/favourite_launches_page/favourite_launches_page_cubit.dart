import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/domain/converters/launch_converter.dart';
import '../../../data/models/launch_dto.dart';
import '../../../domain/entities/launch.dart';
import 'favourite_launches_page_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteLaunchesPageCubit extends Cubit<FavouriteLaunchesPageState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FavoriteLaunchesPageCubit() : super(FavouriteLaunchesInit()) {
    fetchFavouriteLaunches();
  }

  String get currentUserUid => _auth.currentUser?.uid ?? '';

  void fetchFavouriteLaunches() async {
    try {
      final snapshot = await _firestore
          .collection('launches')
          .where('userId', isEqualTo: currentUserUid)
          .get();

      final launches = snapshot.docs.map((e) {
        final launchesDTO = LaunchDTO.fromJson(e.data());
        return LaunchConverter.fromDto(launchesDTO);
      }).toList();

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
      LaunchDTO launchDto = LaunchConverter.toDto(launch);

      await _firestore.collection('launches').doc(launch.id).set({
        ...launchDto.toJson(),
        'userId': currentUserUid,
      });

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

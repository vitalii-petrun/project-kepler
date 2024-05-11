import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/domain/repositories/space_devs_repository.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';

class FetchFavouriteEventsUseCase {
  final FirebaseFirestore firestore;
  String? userId;
  final SpaceDevsRepository apiRepository;
  final LanguageDetectionService languageDetectionService;

  FetchFavouriteEventsUseCase({
    this.userId,
    required this.firestore,
    required this.languageDetectionService,
    required this.apiRepository,
  });

  Future<List<Event>> call() async {
    logger.d('Fetching favourite events.  User id: $userId');
    if (userId == null) {
      throw Exception("User ID is null");
    }
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc('events')
          .collection('events')
          .get();

      final events = <Event>[];
      for (final doc in snapshot.docs) {
        final launch = await apiRepository.getEventById(doc.id);

        final translatedLaunch =
            await languageDetectionService.translateIfNecessary(launch);
        events.add(translatedLaunch as Event);
      }

      return events;
    } catch (e) {
      logger.e('Error fetching favourite events: $e');
      rethrow;
    }
  }
}

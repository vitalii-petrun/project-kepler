import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/domain/repositories/launch_library_repository.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

class FetchFavouriteEventsUseCase {
  final FirebaseFirestore firestore;
  String? userId;
  final LaunchLibraryRepository apiRepository;

  FetchFavouriteEventsUseCase({
    required this.firestore,
    this.userId,
    required this.apiRepository,
  });
  Future<List<Event>> call() async {
    logger.d('Fetching favourite events. User id: $userId');
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

      final events = await Future.wait(snapshot.docs.map((doc) async {
        final event = await apiRepository.getEventById(doc.id);
        return await locator<LocaleTranslationService>()
            .translateIfNecessary(event) as Event;
      }).toList());

      return events;
    } catch (e) {
      logger.e('Error fetching favourite events: $e');
      rethrow;
    }
  }
}

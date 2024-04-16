import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/domain/repositories/article_repository.dart';

class FetchFavouriteEventsUseCase {
  final FirebaseFirestore firestore;
  String? userId;
  final ArticleRepository apiRepository;

  FetchFavouriteEventsUseCase({
    this.userId,
    required this.firestore,
    required this.apiRepository,
  });

  Future<List<Event>> call() async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc('events')
        .collection('events')
        .get();

    final events = <Event>[];
    for (final doc in snapshot.docs) {
      final launch = await apiRepository.getArticleById(doc.id);

      final translatedLaunch =
          await languageDetectionService.translateIfNecessary(launch);
      events.add(translatedLaunch as Event);
    }

    return events;
  }
}

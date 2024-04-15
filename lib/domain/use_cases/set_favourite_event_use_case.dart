import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/data/models/event2_dto.dart';
import 'package:project_kepler/domain/converters/event_converter.dart';
import 'package:project_kepler/domain/entities/event.dart';

class SetFavouriteEventUseCase {
  final FirebaseFirestore firestore;
  String? userId;
  final EventEntityToDtoConverter entityToDtoConverter;

  SetFavouriteEventUseCase({
    required this.firestore,
    this.userId,
    required this.entityToDtoConverter,
  });

  Future<void> call(Event event) async {
    EventDTO eventDTO = entityToDtoConverter.convert(event);
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc("events")
        .collection('events')
        .doc(eventDTO.id.toString())
        .set({
      'id': eventDTO.id,
      'name': eventDTO.name,
    });
  }
}

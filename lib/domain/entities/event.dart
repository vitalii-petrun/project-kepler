import 'package:project_kepler/domain/entities/expedition.dart';
import 'package:project_kepler/domain/entities/launch.dart';
import 'package:project_kepler/domain/entities/spacestation.dart';
import 'package:project_kepler/domain/entities/type.dart';

class Event {
  final int id;
  final String url;

  final String name;

  final TypeEntity type;
  final String description;
  final bool webcastLive;
  final String location;
  final String? newsUrl;
  final String? videoUrl;
  final String featureImage;
  final DateTime date;

  final List<Launch> launches;
  final List<Expedition> expeditions;
  final List<SpaceStation> spaceStations;

  Event({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.description,
    required this.webcastLive,
    required this.location,
    required this.newsUrl,
    required this.videoUrl,
    required this.featureImage,
    required this.date,
    required this.launches,
    required this.expeditions,
    required this.spaceStations,
  });
}

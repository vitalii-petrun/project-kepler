import 'package:project_kepler/domain/entities/expedition.dart';
import 'package:project_kepler/domain/entities/spacestation.dart';
import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/domain/entities/type.dart';

class Event implements Translatable {
  final int id;
  final String url;
  final String name;
  final TypeEntity type;
  String description;
  final bool webcastLive;
  final String location;
  final String? newsUrl;
  final String? videoUrl;
  final String featureImage;
  final DateTime date;
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
    required this.expeditions,
    required this.spaceStations,
  });
  //debug purposes
  Event.empty()
      : id = 0,
        url = '',
        name = '',
        type = TypeEntity(
          id: 0,
          name: '',
        ),
        description = '',
        webcastLive = false,
        location = '',
        newsUrl = '',
        videoUrl = '',
        featureImage = '',
        date = DateTime.now(),
        expeditions = [],
        spaceStations = [];

  @override
  List<Translatable> getNestedTranslatables() {
    return [];
  }

  @override
  Map<String, dynamic> getTranslatableFields() {
    return {
      'description': description,
    };
  }

  @override
  void updateWithTranslatedFields(Map<String, dynamic> translatedFields) {
    if (translatedFields.containsKey('description')) {
      description = translatedFields['description'];
    }
  }
}

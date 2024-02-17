import 'package:project_kepler/domain/entities/spacestation.dart';

class Expedition {
  final String id;
  final String url;
  final String name;
  final String start;
  final String? end;
  final SpaceStation spacestation;
  final List<String> missionPatches;
  final List<String> spacewalks;

  Expedition({
    required this.id,
    required this.url,
    required this.name,
    required this.start,
    this.end,
    required this.spacestation,
    required this.missionPatches,
    required this.spacewalks,
  });
}

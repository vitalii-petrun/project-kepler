import 'package:project_kepler/domain/entities/spacestation.dart';

class Expedition {
  final int id;
  final String url;
  final String name;
  final String start;
  final String? end;
  final SpaceStation spacestation;

  Expedition({
    required this.id,
    required this.url,
    required this.name,
    required this.start,
    this.end,
    required this.spacestation,
  });
}

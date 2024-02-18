import 'package:project_kepler/domain/entities/type.dart';

class SpaceStation {
  final int id;
  final String url;
  final String name;
  final TypeEntity status;
  final String founded;
  final String description;
  final String orbit;
  final String imageUrl;

  SpaceStation({
    required this.id,
    required this.url,
    required this.name,
    required this.status,
    required this.founded,
    required this.description,
    required this.orbit,
    required this.imageUrl,
  });
}

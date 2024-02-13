import 'package:project_kepler/domain/entities/orbit.dart';

/// Space mission within which the launch is carried out.
class Mission {
  /// ID of mission.
  final int id;

  /// Mission name.
  final String name;

  /// Description of mission.
  final String description;

  /// Mission type.
  final String type;

  /// Orbit on which mission will be provided.
  final Orbit orbit;

  /// Creates [Mission] object.
  Mission(this.id, this.name, this.description, this.type, this.orbit);
}

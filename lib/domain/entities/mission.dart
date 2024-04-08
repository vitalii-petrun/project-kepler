import 'package:project_kepler/domain/entities/orbit.dart';
import 'package:project_kepler/domain/entities/translatable.dart';

/// Space mission within which the launch is carried out.
class Mission implements Translatable {
  /// ID of mission.
  final int id;

  /// Mission name.
  final String name;

  /// Description of mission.
  String description;

  /// Mission type.
  final String type;

  /// Orbit on which mission will be provided.
  final Orbit orbit;

  /// Creates [Mission] object.
  Mission(this.id, this.name, this.description, this.type, this.orbit);

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

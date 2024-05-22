import 'package:project_kepler/domain/entities/translatable.dart';

/// Physical location of the site.
class PadLocation extends Translatable {
  /// ID of object.
  final int id;

  /// Name of launch pad.
  String name;

  /// Total launch count
  final int? totalLaunchCount;

  /// Total landing count.
  final int? totalLandingCount;

  ///Сreates [PadLocation] object.
  PadLocation(
    this.id,
    this.name,
    this.totalLaunchCount,
    this.totalLandingCount,
  );

  /// Creates empty [PadLocation] object.
  PadLocation.empty()
      : id = 0,
        name = '',
        totalLaunchCount = 0,
        totalLandingCount = 0;

  @override
  Map<String, dynamic> getTranslatableFields() {
    return {"name": name};
  }

  @override
  void updateWithTranslatedFields(Map<String, dynamic> translatedFields) {
    if (translatedFields.containsKey('name')) {
      name = translatedFields['name'];
    }
  }
}

import 'package:project_kepler/domain/entities/pad_location.dart';
import 'package:project_kepler/domain/entities/translatable.dart';

/// Describes place where launch of rocket is provided.
class Pad extends Translatable {
  /// ID of object.
  final int id;

  /// ID of agency which provides the launch.

  final int? agencyID;

  /// Pad name.
  String name;

  /// Physical location of the site.
  final PadLocation location;

  /// Creates [Pad] object.
  Pad(this.id, this.agencyID, this.name, this.location);

  /// Creates empty [Pad] object.
  Pad.empty()
      : id = 0,
        agencyID = 0,
        name = '',
        location = PadLocation.empty();

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

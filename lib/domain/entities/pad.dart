import 'package:project_kepler/domain/entities/pad_location.dart';

/// Describes place where launch of rocket is provided.
class Pad {
  /// ID of object.
  final int id;

  /// ID of agency which provides the launch.

  final int? agencyID;

  /// Pad name.
  final String name;

  /// Physical location of the site.
  final PadLocation location;

  /// Creates [Pad] object.
  Pad(this.id, this.agencyID, this.name, this.location);
}

import 'manufacturer.dart';

/// Describes parameters of rocket.
class RocketConfiguration {
  /// ID of object.
  final int id;

  /// Rocket's name.
  final String name;

  /// Rocket's family.
  final String family;

  /// Full name.
  final String fullName;

  /// Rocket's variant.
  final String variant;

  /// Rocket's manufacturer.
  final Manufacturer? manufacturer;

  /// URL for additional information about the rocket.

  final String? infoUrl;

  /// URL for the rocket's wikipedia page.

  final String? wikiUrl;

  final String? imageURL;

  /// Creates [RocketConfiguration] object
  RocketConfiguration(
    this.id,
    this.name,
    this.family,
    this.fullName,
    this.variant,
    this.manufacturer,
    this.infoUrl,
    this.wikiUrl,
    this.imageURL,
  );
}

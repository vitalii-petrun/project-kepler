import 'package:project_kepler/domain/entities/rocket_configuration.dart';

/// Describes rocket object
class Rocket {
  /// ID of object.
  final int id;

  /// Rocket's configuration.
  RocketConfiguration configuration;

  /// Creates [Rocket] object.
  Rocket(this.id, this.configuration);

  /// Creates empty [Rocket] object.
  Rocket.empty()
      : id = 0,
        configuration = RocketConfiguration.empty();
}

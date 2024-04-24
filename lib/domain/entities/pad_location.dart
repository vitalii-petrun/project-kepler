/// Physical location of the site.
class PadLocation {
  /// ID of object.
  final int id;

  /// Name of launch pad.
  final String name;

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
}

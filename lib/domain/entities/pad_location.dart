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
}

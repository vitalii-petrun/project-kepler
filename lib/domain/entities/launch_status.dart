class LaunchStatus {
  final int id;
  final String name;
  final String description;

  LaunchStatus(this.id, this.name, this.description);

  factory LaunchStatus.empty() {
    return LaunchStatus(0, '', '');
  }
}

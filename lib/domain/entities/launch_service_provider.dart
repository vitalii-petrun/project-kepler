class LaunchServiceProvider {
  final int id;
  final String name;
  final String? type;

  LaunchServiceProvider(
    this.id,
    this.name,
    this.type,
  );

  factory LaunchServiceProvider.empty() {
    return LaunchServiceProvider(0, '', '');
  }
}

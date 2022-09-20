import 'package:json_annotation/json_annotation.dart';

part 'launch_service_provider.g.dart';

@JsonSerializable()

/// Company which handles launch.
class LaunchServiceProvider {
  /// ID of object.
  final int id;

  /// Name of company.
  final String name;

  /// Type of company.
  final String? type;

  /// Creates [LaunchServiceProvider] object.
  LaunchServiceProvider(
    this.id,
    this.name,
    this.type,
  );

  ///Converter from json to [LaunchServiceProvider] object.
  factory LaunchServiceProvider.fromJson(Map<String, dynamic> json) =>
      _$LaunchServiceProviderFromJson(json);

  ///Converter from  [LaunchServiceProvider] object to json.
  Map<String, dynamic> toJson() => _$LaunchServiceProviderToJson(this);
}

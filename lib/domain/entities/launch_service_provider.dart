import 'package:json_annotation/json_annotation.dart';

part 'launch_service_provider.g.dart';

@JsonSerializable()
class LaunchServiceProvider {
  final int id;
  final String name;
  final String? type;

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

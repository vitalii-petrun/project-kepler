import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/domain/entities/launch.dart';

part 'launch_list.g.dart';

@JsonSerializable()

/// Handles top-level API response.
class LaunchList {
  
   /// List of Launch items.
  @JsonKey(name: 'result')
  final List<Launch> itemList;

  LaunchList(this.itemList);

   ///Converter from json to [LaunchStatus] object.
  factory LaunchList.fromJson(Map<String, dynamic> json) =>
      _$LaunchListFromJson(json);

  ///Converter from  [LaunchStatus] object to json.
  Map<String, dynamic> toJson() => _$LaunchListToJson(this);
}

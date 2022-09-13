// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchList _$LaunchListFromJson(Map<String, dynamic> json) => LaunchList(
      (json['result'] as List<dynamic>)
          .map((e) => Launch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LaunchListToJson(LaunchList instance) =>
    <String, dynamic>{
      'result': instance.itemList,
    };

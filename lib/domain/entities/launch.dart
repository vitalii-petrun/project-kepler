import 'package:project_kepler/domain/entities/launch_service_provider.dart';
import 'package:project_kepler/domain/entities/launch_status.dart';
import 'package:project_kepler/domain/entities/mission.dart';
import 'package:project_kepler/domain/entities/pad.dart';
import 'package:project_kepler/domain/entities/rocket.dart';
import 'package:project_kepler/domain/entities/translatable.dart';

class Launch implements Translatable {
  final String id;
  final String net;
  String name;
  final LaunchStatus status;
  final LaunchServiceProvider launchServiceProvider;
  final Mission? mission;
  final Rocket rocket;
  final String? image;

  final Pad pad;

  Launch(
    this.id,
    this.name,
    this.status,
    this.net,
    this.launchServiceProvider,
    this.rocket,
    this.mission,
    this.pad,
    this.image,
  );

  @override
  Map<String, dynamic> getTranslatableFields() {
    return {
      'name': name,
    };
  }

  @override
  void updateWithTranslatedFields(Map<String, dynamic> translatedFields) {
    if (translatedFields.containsKey('name')) {
      name = translatedFields['name'];
    }
  }

  @override
  List<Translatable> getNestedTranslatables() {
    return mission != null ? [mission!] : [];
  }
}

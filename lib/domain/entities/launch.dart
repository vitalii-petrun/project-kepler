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

  Launch.empty()
      : id = '',
        name = '',
        status = LaunchStatus.empty(),
        net = '',
        launchServiceProvider = LaunchServiceProvider.empty(),
        rocket = Rocket.empty(),
        mission = null,
        pad = Pad.empty(),
        image = '';

  @override
  Map<String, dynamic> getTranslatableFields() {
    return {};
  }

  @override
  void updateWithTranslatedFields(Map<String, dynamic> translatedFields) {}

  @override
  List<Translatable> getNestedTranslatables() {
    List<Translatable> nestedTranslatables = [];
    if (mission != null) {
      nestedTranslatables.add(mission!);
    }

    return nestedTranslatables;
  }
}

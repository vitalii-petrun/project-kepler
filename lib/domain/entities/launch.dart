import 'package:project_kepler/domain/entities/launch_service_provider.dart';
import 'package:project_kepler/domain/entities/launch_status.dart';
import 'package:project_kepler/domain/entities/mission.dart';
import 'package:project_kepler/domain/entities/pad.dart';
import 'package:project_kepler/domain/entities/rocket.dart';

class Launch {
  final String id;
  final String net;
  final String name;
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
}

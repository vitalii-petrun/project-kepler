import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/domain/entities/launch.dart';

import '../entities/agency.dart';

abstract class ApiRepository {
  Future<List<Launch>> getUpcomingLaunchList();
  Future<List<Launch>> getLaunchList();
  Future<Launch> getLaunchDetailsById(String id);
  Future<List<Event>> getAllEvents();
  Future<Agency?> getAgencyById(int? id);
}

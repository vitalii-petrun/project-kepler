import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/domain/entities/launch.dart';

import '../entities/agency.dart';

abstract class SpaceDevsRepository {
  Future<List<Launch>> getUpcomingLaunchList();
  Future<List<Launch>> getLaunchList();
  Future<Launch> getLaunchDetailsById(String id);
  Future<List<Event>> getAllEvents();
  Future<Event> getEventById(String id);
  Future<Agency?> getAgencyById(int? id);
}

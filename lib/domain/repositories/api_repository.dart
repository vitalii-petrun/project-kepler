import 'package:project_kepler/domain/entities/launch.dart';

import '../entities/agency.dart';

abstract class ApiRepository {
  Future<List<Launch>> getLaunchList();
  Future<Launch> getLaunchDetails(String id);
  Future<Agency> getAgency(int id);
}

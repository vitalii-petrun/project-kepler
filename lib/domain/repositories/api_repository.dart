import 'package:project_kepler/domain/entities/launch.dart';

import '../entities/agency.dart';

abstract class ApiRepository {
  Future<List<Launch>> getLaunchList();
  Future<Launch> getLaunchDetailsById(String id);
  Future<Agency?> getAgencyById(int? id);
}

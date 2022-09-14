import 'package:project_kepler/domain/entities/launch.dart';

abstract class ApiRepository {
  Future<List<Launch>> getLaunchList();
}

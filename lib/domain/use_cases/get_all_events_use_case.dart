import 'package:project_kepler/domain/entities/event.dart';

import '../../data/repositories/api_repository_impl.dart';

class GetAllEventsUseCase {
  final ApiRepositoryImpl repository;

  GetAllEventsUseCase(this.repository);

  Future<List<Event>> call() async {
    return await repository.getAllEvents();
  }
}

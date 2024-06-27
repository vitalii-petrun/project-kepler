import 'package:injectable/injectable.dart';
import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/data/data%20sources/remote/api_client.dart';
import 'package:project_kepler/data/repositories/launch_library_repository_impl.dart';
import 'package:project_kepler/domain/converters/agency_converter.dart';
import 'package:project_kepler/domain/converters/event_converter.dart';
import 'package:project_kepler/domain/converters/launch_converter.dart';
import 'package:project_kepler/domain/repositories/launch_library_repository.dart';

@module
abstract class LaunchLibraryRepositoryModule {
  @lazySingleton
  LaunchLibraryRepository get launchLibraryRepository {
    return LaunchLibraryRepositoryImpl(
      locator<ApiClient>(),
      _launchConverter,
      _eventConverter,
      _agencyConverter,
    );
  }

  @lazySingleton
  LaunchDtoToEntityConverter get _launchConverter =>
      LaunchDtoToEntityConverter();

  @lazySingleton
  EventDtoToEntityConverter get _eventConverter => EventDtoToEntityConverter();

  @lazySingleton
  AgencyDtoToEntityConverter get _agencyConverter =>
      AgencyDtoToEntityConverter();
}

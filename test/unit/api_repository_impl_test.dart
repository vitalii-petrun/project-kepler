import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_kepler/data/data%20sources/remote/api_client.dart';
import 'package:project_kepler/data/repositories/space_devs_repository_impl.dart';
import 'package:project_kepler/domain/converters/agency_converter.dart';
import 'package:project_kepler/domain/converters/event_converter.dart';
import 'package:project_kepler/domain/converters/launch_converter.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/core/di/configuration.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:project_kepler/domain/repositories/space_devs_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SpaceDevsRepository apiRepositoryImpl;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await locator.reset();
    await dotenv.load();
    await configureDependencies();
    apiRepositoryImpl = SpaceDevsRepositoryImpl(
      locator<ApiClient>(),
      LaunchDtoToEntityConverter(),
      EventDtoToEntityConverter(),
      AgencyDtoToEntityConverter(),
    );
  });

  tearDownAll(() {
    locator.reset();
  });

  group('ApiRepositoryImpl', () {
    test('should return error when fetching launches', () async {
      when(apiRepositoryImpl.getLaunchList())
          .thenThrow(Exception('Failed to fetch data'));

      expect(() => apiRepositoryImpl.getLaunchList(), throwsException);
    });

    test('should return a list of events', () async {
      when(apiRepositoryImpl.getAllEvents());

      final events = await apiRepositoryImpl.getAllEvents();
      print(events);
      expect(events, isA<List<Event>>());
    });
  });
}

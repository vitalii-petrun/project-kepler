// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:project_kepler/domain/entities/launch.dart';
// import 'package:project_kepler/domain/use_cases/get_all_launches_use_case.dart';

// import '../helpers/test_helpers.mocks.dart';

// void main() {
//   late GetAllLaunchesUseCase fetchLaunchesUseCase;
//   late MockSpaceDevsRepository apiRepository;
//   late MockLanguageDetectionService languageDetectionService;

//   setUp(() {
//     // Mocked use case's dependencies.
//     languageDetectionService = MockLanguageDetectionService();
//     apiRepository = MockSpaceDevsRepository();
//     fetchLaunchesUseCase = GetAllLaunchesUseCase(
//       apiRepository,
//       languageDetectionService, // TODO: pass the service.
//     );
//   });

//   group('FetchLaunchesUseCase', () {
//     test('should return a list of launches', () async {
//       final launches = await fetchLaunchesUseCase();

//       expect(launches, isA<List<Launch>>());
//     });

//     test('should return an empty list of launches', () async {
//       when(fetchLaunchesUseCase()).thenAnswer((_) async => <Launch>[]);

//       final launches = await fetchLaunchesUseCase();

//       expect(launches, isEmpty);
//     });

//     test('should return a list of launches with length 1', () async {
//       when(fetchLaunchesUseCase()).thenAnswer((_) async => <Launch>[
//             Launch.empty(),
//           ]);

//       final launches = await fetchLaunchesUseCase();

//       expect(launches, hasLength(1));
//     });
//   });
// }

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_kepler/domain/entities/launch.dart';
import 'package:project_kepler/presentation/cubits/launches/launches_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/launches/launches_page_state.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  group('LaunchesPageCubit', () {
    late MockGetAllLaunchesUseCase getAllLaunchesUseCase;
    late LaunchesPageCubit launchesPageCubit;

    setUp(() {
      getAllLaunchesUseCase = MockGetAllLaunchesUseCase();
      launchesPageCubit = LaunchesPageCubit(getAllLaunchesUseCase);
    });

    blocTest<LaunchesPageCubit, LaunchesPageState>(
      'emits [LaunchesLoading, LaunchesLoaded] when fetch is successful',
      build: () => launchesPageCubit,
      act: (cubit) => cubit.fetch(),
      setUp: () {
        // Налаштовуємо макет, щоб повернути список Launch
        when(getAllLaunchesUseCase()).thenAnswer((_) async => [Launch.empty()]);
      },
      expect: () => [
        LaunchesLoading(),
        LaunchesLoaded([Launch.empty()])
      ],
    );

    blocTest<LaunchesPageCubit, LaunchesPageState>(
      'emits [LaunchesLoading, LaunchesError] when fetch fails',
      build: () => launchesPageCubit,
      act: (cubit) => cubit.fetch(),
      setUp: () {
        // Налаштовуємо макет, щоб викинути виняток
        when(getAllLaunchesUseCase())
            .thenThrow(Exception('Failed to fetch launches'));
      },
      expect: () => [
        LaunchesLoading(),
        LaunchesError('Exception: Failed to fetch launches')
      ],
    );
  });
}

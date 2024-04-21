import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:project_kepler/data/repositories/api_repository_impl.dart';
import 'package:project_kepler/domain/repositories/api_repository.dart';

@GenerateNiceMocks([MockSpec<ApiRepositoryImpl>()])
import 'api_repository_impl_test.mocks.dart';

void main() {
  late ApiRepositoryImpl apiRepositoryImpl;

  setUp(() {
    apiRepositoryImpl = MockApiRepositoryImpl();
  });

  group('ApiRepositoryImpl', () {
    test('should be a subclass of ApiRepository', () {
      expect(apiRepositoryImpl, isA<ApiRepository>());
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/data/repositories/chat_repository_impl.dart';

void main() {
  group('ChatRepositoryImpl', () {
    late ChatRepositoryImpl chatRepository;

    setUp(() async {
      chatRepository = await ChatRepositoryImpl.create();
    });

    test('generateAIResponse returns a non-empty string', () async {
      const userMessage = 'What is the largest planet in our solar system?';
      final aiResponse = await chatRepository.generateAIResponse(userMessage);
      expect(aiResponse, isNotEmpty);
      expect(aiResponse, contains('Jupiter'));
      logger.i(aiResponse);
    });

    test('generateAIResponse handles context correctly', () async {
      // Arrange
      const userMessage = 'Who is the main architect of the rocket?';
      Map<String, dynamic> context = {
        'rocket': {
          'name': 'Saturn V',
        }
      };

      // Act
      final aiResponse = await chatRepository.generateAIResponse(userMessage,
          context: context);

      // Assert
      expect(aiResponse, isNotEmpty);
      expect(aiResponse, contains('Wernher von Braun'));
      logger.i(aiResponse);
    });
  });
}

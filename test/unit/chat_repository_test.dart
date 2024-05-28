import 'package:flutter_test/flutter_test.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/data/repositories/chat_repository_impl.dart';
import 'package:project_kepler/domain/repositories/chat_repository.dart';

void main() {
  Future<ChatRepository> chatRepository = ChatRepositoryImpl.create();

  test('ChatRepositoryImpl.create() should return a ChatRepositoryImpl object',
      () async {
    expect(await chatRepository, isA<ChatRepository>());
  });

  test('should return a response when generateResponse is called', () async {
    ChatRepository chatRepo = await chatRepository;
    String response = await chatRepo
        .generateAIResponse("What's the biggest planet in the solar system?");
    logger.i(response);
    expect(response, isA<String>());
    //expect it contains the string "Jupiter"
    expect(response, contains("Jupiter"));
  });
}

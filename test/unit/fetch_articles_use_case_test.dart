import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:project_kepler/domain/entities/article.dart';
import 'package:project_kepler/domain/use_cases/fetch_articles_use_case.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  late FetchArticlesUseCase fetchArticlesUseCase;

  setUp(() {
    fetchArticlesUseCase = MockFetchArticlesUseCase();
  });

  group('FetchArticlesUseCase', () {
    test('should call repository.fetchArticles()', () async {
      await fetchArticlesUseCase();

      verify(fetchArticlesUseCase());

      verifyNoMoreInteractions(fetchArticlesUseCase);
    });

    test('should return a list of articles', () async {
      final articles = await fetchArticlesUseCase();

      expect(articles, isA<List<Article>>());
    });

    test('should return an empty list of articles', () async {
      when(fetchArticlesUseCase()).thenAnswer((_) async => <Article>[]);

      final articles = await fetchArticlesUseCase();

      expect(articles, isEmpty);
    });

    test('should return a list of articles with length 1', () async {
      when(fetchArticlesUseCase()).thenAnswer((_) async => <Article>[
            Article(
              id: 1,
              title: 'title',
              newsSite: 'newsSite',
              summary: 'summary',
              updatedAt: DateTime.now(),
              featured: true,
              url: 'url',
              imageUrl: 'imageUrl',
              publishedAt: DateTime.now(),
            )
          ]);

      final articles = await fetchArticlesUseCase();

      expect(articles, hasLength(1));
    });
  });
}

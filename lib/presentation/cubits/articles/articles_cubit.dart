import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/fetch_articles_use_case.dart';
import 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final FetchArticlesUseCase fetchArticlesUseCase;

  ArticlesCubit(this.fetchArticlesUseCase) : super(ArticlesInitial());

  Future<void> fetchArticles() async {
    emit(ArticlesLoading());
    try {
      final articles = await fetchArticlesUseCase();
      emit(ArticlesLoaded(articles));
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }
}

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

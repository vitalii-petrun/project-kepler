import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_state.dart';

import '../../../domain/use_cases/fetch_blogs_use_case.dart';
import '../../../domain/use_cases/fetch_articles_use_case.dart';
import '../../../domain/use_cases/fetch_nasa_articles_use_case.dart';
import '../../../domain/use_cases/fetch_spacex_articles_use_case.dart';

class NewsCubit extends Cubit<NewsState> {
  final FetchArticlesUseCase fetchRecentArticlesUseCase;
  final FetchSpaceXArticlesUseCase fetchSpaceXArticlesUseCase;
  final FetchNasaArticlesUseCase fetchNasaArticlesUseCase;
  final FetchBlogsUseCase fetchBlogsUseCase;

  NewsCubit({
    required this.fetchRecentArticlesUseCase,
    required this.fetchSpaceXArticlesUseCase,
    required this.fetchNasaArticlesUseCase,
    required this.fetchBlogsUseCase,
  }) : super(NewsLoading());

  Future<void> fetchRecentArticles() async {
    _fetchData<RecentArticlesLoaded>(
      fetchUseCase: fetchRecentArticlesUseCase,
      onSuccess: (articles) => RecentArticlesLoaded(articles),
    );
  }

  Future<void> fetchSpaceXArticles() async {
    _fetchData<SpaceXArticlesLoaded>(
      fetchUseCase: fetchSpaceXArticlesUseCase,
      onSuccess: (articles) => SpaceXArticlesLoaded(articles),
    );
  }

  Future<void> fetchNasaArticles() async {
    _fetchData<NasaArticlesLoaded>(
      fetchUseCase: fetchNasaArticlesUseCase,
      onSuccess: (articles) => NasaArticlesLoaded(articles),
    );
  }

  Future<void> fetchBlogs() async {
    _fetchData<BlogsLoaded>(
      fetchUseCase: fetchBlogsUseCase,
      onSuccess: (blogs) => BlogsLoaded(blogs),
    );
  }

  Future<void> _fetchData<T>({
    required Future<dynamic> Function() fetchUseCase,
    required T Function(dynamic) onSuccess,
  }) async {
    emit(NewsLoading());
    try {
      final result = await fetchUseCase();
      emit(onSuccess(result) as NewsState);
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}

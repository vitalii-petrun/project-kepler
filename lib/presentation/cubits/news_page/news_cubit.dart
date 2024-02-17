import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_state.dart';

import '../../../domain/use_cases/fetch_articles_use_case.dart';

class NewsCubit extends Cubit<NewsState> {
  final FetchArticlesUseCase fetchRecentArticlesUseCase;

  NewsCubit({
    required this.fetchRecentArticlesUseCase,
  }) : super(NewsLoading());

  Future<void> fetchRecentArticles() async {
    _fetchData<RecentArticlesLoaded>(
      fetchUseCase: fetchRecentArticlesUseCase,
      onSuccess: (articles) => RecentArticlesLoaded(articles),
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

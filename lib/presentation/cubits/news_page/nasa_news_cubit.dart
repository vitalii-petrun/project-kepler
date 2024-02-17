import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_state.dart';

import '../../../domain/use_cases/fetch_nasa_articles_use_case.dart';

class NasaNewsCubit extends Cubit<NewsState> {
  final FetchNasaArticlesUseCase fetchNasaArticlesUseCase;

  NasaNewsCubit({
    required this.fetchNasaArticlesUseCase,
  }) : super(NewsLoading());

  Future<void> fetchNasaArticles() async {
    _fetchData<NasaArticlesLoaded>(
      fetchUseCase: fetchNasaArticlesUseCase,
      onSuccess: (articles) => NasaArticlesLoaded(articles),
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

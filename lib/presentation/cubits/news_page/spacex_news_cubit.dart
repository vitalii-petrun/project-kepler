import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_state.dart';

import '../../../domain/use_cases/fetch_spacex_articles_use_case.dart';

class SpaceXNewsCubit extends Cubit<NewsState> {
  final FetchSpaceXArticlesUseCase fetchSpaceXArticlesUseCase;

  SpaceXNewsCubit({
    required this.fetchSpaceXArticlesUseCase,
  }) : super(NewsLoading());

  Future<void> fetchSpaceXArticles() async {
    _fetchData<SpaceXArticlesLoaded>(
      fetchUseCase: fetchSpaceXArticlesUseCase,
      onSuccess: (articles) => SpaceXArticlesLoaded(articles),
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

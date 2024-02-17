import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_state.dart';

import '../../../domain/use_cases/fetch_blogs_use_case.dart';

class BlogsCubit extends Cubit<NewsState> {
  final FetchBlogsUseCase fetchBlogsUseCase;

  BlogsCubit({
    required this.fetchBlogsUseCase,
  }) : super(NewsLoading());

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

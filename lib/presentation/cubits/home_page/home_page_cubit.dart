// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project_kepler/domain/use_cases/fetch_articles_use_case.dart';
// import 'package:project_kepler/domain/use_cases/get_all_events_use_case.dart';

// import 'package:project_kepler/presentation/cubits/home_page/home_page_state.dart';

// import '../../../domain/use_cases/get_upcoming_launches_use_case.dart';

// class HomePageCubit extends Cubit<HomePageState> {
//   final GetUpcomingLaunchesUseCase getUpcomingLaunchesUseCase;
//   final GetAllEventsUseCase getAllEventsUseCase;
//   final FetchArticlesUseCase fetchArticlesUseCase;

//   HomePageCubit(this.getUpcomingLaunchesUseCase, this.getAllEventsUseCase,
//       this.fetchArticlesUseCase)
//       : super(HomePageInitial());

//   void fetch() async {
//     emit(HomePageLoading());
//     try {
//       final launches = await getUpcomingLaunchesUseCase();
//       final events = await getAllEventsUseCase();
//       final articles = await fetchArticlesUseCase();
//       emit(HomePageLoaded(launches, events, articles));
//     } catch (e) {
//       emit(HomePageError(e.toString()));
//     }
//   }
// }

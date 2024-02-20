import 'package:project_kepler/domain/entities/article.dart';
import 'package:project_kepler/domain/entities/event.dart';

import '../../../domain/entities/launch.dart';

abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final List<Launch> launches;
  final List<Event> events;
  final List<Article> articles;

  HomePageLoaded(this.launches, this.events, this.articles);
}

class HomePageError extends HomePageState {
  final String message;

  HomePageError(this.message);
}

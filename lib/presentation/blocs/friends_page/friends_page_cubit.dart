import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/data/repositories/api_repository_impl.dart';
import 'friends_page_state.dart';

class FriendsPageCubit extends Cubit<FriendsPageState> {
  final ApiRepositoryImpl repository;

  FriendsPageCubit(this.repository) : super(FriendsInit());
  void fetch() async {
    emit(FriendsLoading());
    await repository
        .getUserList()
        .then((launches) => emit(FriendsLoaded(launches)))
        .catchError((e) => emit(FriendsError(e.toString())));
  }
}

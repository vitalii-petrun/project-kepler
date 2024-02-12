import 'package:flutter_bloc/flutter_bloc.dart';
import 'friends_page_state.dart';
import '../../../domain/use_cases/fetch_friends_use_case.dart';

class FriendsPageCubit extends Cubit<FriendsPageState> {
  final FetchFriendsUseCase fetchFriendsUseCase;

  FriendsPageCubit(this.fetchFriendsUseCase) : super(FriendsInit());

  void fetchFriends(String currentUserId) async {
    emit(FriendsLoading());
    try {
      final friends = await fetchFriendsUseCase(currentUserId);
      emit(FriendsLoaded(friends));
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }
}

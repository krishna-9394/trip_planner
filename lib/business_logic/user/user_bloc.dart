import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/users.dart';
import '../../data/services/trip_services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final TripsRepo _repo = TripsRepo();
  UserBloc() : super(InitializingUsersState()) {
    on<LoadingUsersEvent>((event, emit) async {
      await _repo.init();
      emit(LoadingUsersState());
      try {
        emit(LoadedUsersState(
            size: await _repo.usersCount(event.tripIndex), users: await _repo.usersList(event.tripIndex)));
      } catch (error) {
        emit(FailedToLoadUsersState(error: error as Error));
      }
    });
    on<AddingUserEvent>((event, emit) async {
      late String error;
      if (event.userName.compareTo("") == 0) {
        error = "null values not allowed";
        emit(FailedToAddUser(error: error));
      } else if (await _repo.searchUser(event.userName, event.tripIndex)) {
        error = "null values not allowed";
        emit(FailedToAddUser(error: error));
      } else {
        _repo.addUser(event.tripIndex, event.userName);
        emit(AddedUsersState());
        emit(LoadedUsersState(
            size: await _repo.usersCount(event.tripIndex), users: await _repo.usersList(event.tripIndex)));
      }
    });
  }
}

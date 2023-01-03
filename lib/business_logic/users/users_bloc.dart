import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/Models/user.dart';
import '../../data/repositories/users_repositories.dart';

part 'users_event.dart';
part 'users_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late UserRepo _userRepo;
  UserBloc() : super(UserInitialState()) {
    on<LoadUserListEvent>((event, emit) async {
      _userRepo = UserRepo();
      emit(UserInitialState());
      _userRepo.init();
      emit(UserLoadingState());
      try {
        emit(UserLoadedState(users: await _userRepo.getList()));
      } catch (error) {
        emit(FailedToLoadUserState(error: error as Error));
      }
    });
    on<ReloadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        emit(UserLoadedState(users: await _userRepo.getList()));
      } catch (error) {
        print(error.toString());
        emit(FailedToLoadUserState(error: error as Error));
      }
    });
    on<AddUserEvent>((event, emit) async {
      bool isAdded = await _userRepo.addUser(event.tripName, event.userName, event.paid, event.tripIndex);
      emit(AddUserState(
          isAdded: isAdded, note: isAdded ? "successfully added" : "either field is blank or name already exists"));
      add(ReloadUserEvent(tripList: await _userRepo.getList()));
    });
  }
}

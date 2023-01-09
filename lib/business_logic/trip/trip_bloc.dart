import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO getting error in LateInitialization

import '../../data/models/trips.dart';
import '../../data/models/users.dart';
import '../../data/services/trip_services.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripsRepo _repo;
  TripBloc(this._repo) : super(InitializingTripsState()) {
    on<LoadingTripsEvent>((event, emit) async {
      await _repo.init();
      emit(LoadingTripsState());
      try {
        emit(LoadedTripState(trips: await _repo.getList()));
      } catch (error) {
        emit(FailedToLoadTripsState(error: error as Error));
      }
    });
    on<AddingTripEvent>((event, emit) async {
      await _repo.addTrip(event.tripName);
      emit(AddedTripsState());
      try {} catch (error) {
        // TODO add FailedTOAddTripState
        // emit(FailedToAddTripState(error: error as Error));
      }
      emit(LoadedTripState(trips: await _repo.getList()));
    });
    on<DeletingTripEvent>((event, emit) async {
      await _repo.deleteTrip(event.index);
      emit(DeletedTripsState());
      try {} catch (error) {
        // TODO add here also the above one
        // emit(FailedToDeleteTripState(error: error as Error));
      }
      emit(LoadedTripState(trips: await _repo.getList()));
    });
    on<UpdatingTripEvent>((event, emit) async {
      await _repo.updateTrip(event.tripName, event.index);
      emit(UpdatedTripsState());
      try {} catch (error) {
        // TODO add here also the above one
        // emit(FailedToUpdateTripState(error: error as Error));
      }
      emit(LoadedTripState(trips: await _repo.getList()));
    });
    on<LoadingUsersEvent>((event, emit) async {
      emit(LoadingUsersState());
      try {
        emit(LoadedUsersState(size: await _repo.usersCount(event.tripIndex),users: await _repo.usersList(event.tripIndex)));
      } catch (error) {
        emit(FailedToLoadUsersState(error: error as Error));
      }
    });
    on<AddingUserEvent>((event, emit) async {
      late String error;
      if (event.userName.compareTo("") == 0) {
        error = "null values not allowed";
        emit(FailedToAddUser(error: error));
      } else if (await _repo.searchUser(event.userName)) {
        error = "null values not allowed";
        emit(FailedToAddUser(error: error));
      } else {
        _repo.addUser(event.index, event.userName);
        emit(AddedUsersState());
      }
    });
  }
}

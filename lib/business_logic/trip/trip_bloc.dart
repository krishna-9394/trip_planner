import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO getting error in LateInitialization

import '../../data/models/trips.dart';
import '../../data/services/trip_services.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripsRepo _repo = TripsRepo();
  TripBloc() : super(InitializingTripsState()) {
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
  }
}

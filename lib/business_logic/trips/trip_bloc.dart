import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/Models/trip.dart';
import '../../data/repositories/trips_repositories.dart';

part 'trip_events.dart';
part 'trip_states.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  late TripsRepo _repo;
  TripBloc() : super(TripInitialState()) {
    on<LoadingDataEvent>((event, emit) async {
      _repo = TripsRepo();
      emit(TripInitialState());
      await _repo.init();
      emit(TripLoadingState());
      try {
        emit(TripLoadedState(trips: await _repo.getList()));
      } catch (error) {
        print(error.toString());
        emit(FailedToLoadTripState(error: error as Error));
      }
    });
    on<AddTripEvent>((event, emit) async {
      await _repo.addTrip(event.tripName);
      emit(AddedTripState());
      try {
      } catch (error) {
        // TODO add FailedTOAddTripState
        // emit(FailedToAddTripState(error: error as Error));
      }
    });
    on<DeleteTripEvent>((event, emit) async {
      await _repo.deleteTrip(event.index);
      emit(DeletedTripState());
      try {
      } catch (error) {
        // TODO add here also the above one
        // emit(FailedToDeleteTripState(error: error as Error));
      }
    });
    on<UpdateTripEvent>((event, emit) async {
      await _repo.updateTrip(event.tripName, event.index);
      emit(UpdatedTripState());
      try {
      } catch (error) {
        // TODO add here also the above one
        // emit(FailedToUpdateTripState(error: error as Error));
      }
    });
    on<ExtractUser>((event, emit) async {
      emit()
    });
  }
}

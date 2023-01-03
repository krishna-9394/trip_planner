part of 'trip_bloc.dart';

abstract class TripState extends Equatable {}

class TripInitialState extends TripState {
  List<Trip> get tripList => [];

  @override
  // TODO: implement props
  List<Object?> get props => [tripList];
}

class TripLoadingState extends TripState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TripLoadedState extends TripState {
  final List<Trip> trips;
  TripLoadedState({required this.trips});

  @override
  // TODO: implement props
  List<Object?> get props => [trips];
}

class FailedToLoadTripState extends TripState {
  final Error error;
  FailedToLoadTripState({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class AddedTripState extends TripState {
  AddedTripState();
  @override
  List<Object?> get props => [];
}

class DeletedTripState extends TripState {
  DeletedTripState();

  @override
  List<Object?> get props => [];
}

class UpdatedTripState extends TripState {
  UpdatedTripState();
  @override
  List<Object?> get props => [];
}

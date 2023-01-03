part of 'trip_bloc.dart';

abstract class TripEvent extends Equatable {}
// TODO 00 start from here you have implement a event which would start fetching the users

class InitializeBoxEvent extends TripEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingDataEvent extends TripEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeleteTripEvent extends TripEvent {
  final int index;
  DeleteTripEvent({required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class AddTripEvent extends TripEvent {
  final String tripName;
  AddTripEvent({required this.tripName});
  @override
  // TODO: implement props
  List<Object?> get props => [tripName];
}

class UpdateTripEvent extends TripEvent {
  final String tripName;
  final int index;
  UpdateTripEvent({required this.tripName, required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [tripName];
}

class ExtractUser extends TripEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

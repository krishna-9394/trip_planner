part of 'trip_bloc.dart';

abstract class TripEvent extends Equatable {}

class LoadingTripsEvent extends TripEvent {
  @override
  List<Object?> get props => [];
}

class DeletingTripEvent extends TripEvent {
  final int index;
  DeletingTripEvent({required this.index});
  @override
  List<Object?> get props => [index];
}

class AddingTripEvent extends TripEvent {
  final String tripName;
  AddingTripEvent({required this.tripName});
  @override
  List<Object?> get props => [tripName];
}

class UpdatingTripEvent extends TripEvent {
  final String tripName;
  final int index;
  UpdatingTripEvent({required this.tripName, required this.index});
  @override
  List<Object?> get props => [tripName, index];
}

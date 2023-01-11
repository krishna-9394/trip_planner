part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {}

class InitializingTransactionBoxEvent extends TransactionEvent {
  @override
  List<Object?> get props => [];
}

class LoadingTransactionEvent extends TransactionEvent {
  @override
  List<Object?> get props => [];
}

class AddingTransactionEvent extends TransactionEvent {
  final String userName;
  final String tripName;
  final String note;
  final double amount;
  final int tripIndex;
  final int userIndex;
  AddingTransactionEvent({
    required this.tripName,
    required this.userIndex,
    required this.userName,
    required this.note,
    required this.amount,
    required this.tripIndex,
  });
  @override
  List<Object?> get props => [tripIndex, tripName, userName, note, amount, userIndex];
}

class DeletingTransactionEvent extends TransactionEvent {
  final int tripIndex;
  final int transactionIndex;
  DeletingTransactionEvent({
    required this.tripIndex,
    required this.transactionIndex,
  });
  @override
  List<Object?> get props => [tripIndex, transactionIndex];
}

class UpdatingTransactionEvent extends TransactionEvent {
  final String userName;
  final String note;
  final double amount;
  final int tripIndex;
  final int transactionIndex;
  final int userIndex;
  UpdatingTransactionEvent(
      {required this.userName,
      required this.note,
      required this.amount,
      required this.tripIndex,
      required this.transactionIndex,
      required this.userIndex});
  @override
  List<Object?> get props => [tripIndex, userName, note, amount, userIndex];
}

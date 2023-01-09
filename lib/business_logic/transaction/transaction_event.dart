part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable{}

class InitializingTransactionBoxEvent extends TransactionEvent {
  @override
  List<Object?> get props => [];
}

class LoadTransactionListEvent extends TransactionEvent {
  @override
  List<Object?> get props => [];
}

class AddTransactionEvent extends TransactionEvent {
  final String userName;
  final String tripName;
  final String note;
  final double amount;
  final int tripIndex;
  final int userIndex;
  AddTransactionEvent({
    required this.tripName, 
    required this.userIndex, 
    required this.userName,
    required this.note,
    required this.amount,
    required this.tripIndex,
  });
  @override
  List<Object?> get props => [tripIndex,tripName,userName,note,amount,userIndex];
}

class DeleteTransactionEvent extends TransactionEvent {
  final int tripIndex;
  final int transactionIndex;
  DeleteTransactionEvent({
    required this.tripIndex,
    required this.transactionIndex,
  });
  @override
  List<Object?> get props => [tripIndex,transactionIndex];
}

class UpdateTransactionEvent extends TransactionEvent {
  final String userName;
  final String note;
  final double amount;
  final int tripIndex;
  final int transactionIndex;
  final int userIndex;
  UpdateTransactionEvent(
      {required this.userName,
      required this.note,
      required this.amount,
      required this.tripIndex,
      required this.transactionIndex,
      required this.userIndex});
      @override
  List<Object?> get props => [tripIndex,userName,note,amount,userIndex];
}

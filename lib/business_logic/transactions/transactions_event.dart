part of 'transactions_bloc.dart';

abstract class TransactionEvent {}

class LoadTransactionListEvent extends TransactionEvent {
  late List<Transaction> transactionList;
  LoadTransactionListEvent({required this.transactionList});
}

class AddTransactionEvent extends TransactionEvent {
  final String tripName;
  final String userName;
  final String note;
  final double amount;
  final int tripIndex;
  final int userIndex;
  AddTransactionEvent({
    required this.tripName,
    required this.userName,
    required this.note,
    required this.amount,
    required this.tripIndex,
    required this.userIndex,
  });
}

class DeleteTransactionEvent extends TransactionEvent {
  final int tripIndex;
  final int transactionIndex;
  final int userIndex;
  DeleteTransactionEvent({
    required this.tripIndex,
    required this.transactionIndex,
    required this.userIndex,
  });
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
}

class ReloadTransactionEvent extends TransactionEvent {
  late List<Transaction> tripList;
  ReloadTransactionEvent({required this.tripList});
}

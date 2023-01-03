part of 'transactions_bloc.dart';

abstract class TransactionState {}

class TransactionInitialState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionLoadedState extends TransactionState {
  final List<Transaction> transactions;
  final int size;
  TransactionLoadedState({required this.size, required this.transactions});
}

class FailedToLoadTransactionState extends TransactionState {
  final Error error;
  FailedToLoadTransactionState({required this.error});
}

class AddTransactionState extends TransactionState {}

class DeleteTransactionState extends TransactionState {}

class UpdateTransactionState extends TransactionState {}

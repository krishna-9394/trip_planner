// TODO start from here
part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {}

class InitializingTransactionState extends TransactionState {
  @override
  List<Object?> get props => [];
}

class InitializedTransactionState extends TransactionState {
  @override
  List<Object?> get props => [];
}

class LoadingTransactionState extends TransactionState {
  @override
  List<Object?> get props => [];
}

class LoadedTransactionState extends TransactionState {
  final List<Transaction> transactions;
  final int size;
  LoadedTransactionState({required this.size, required this.transactions});
  @override
  List<Object?> get props => [transactions];
}

class FailedToLoadTransactionState extends TransactionState {
  final Error error;
  FailedToLoadTransactionState({required this.error});

  @override
  List<Object?> get props => [error];
}

class AddedTransactionState extends TransactionState {
  @override
  List<Object?> get props => [];
}

class DeletedTransactionState extends TransactionState {
  @override
  List<Object?> get props => [];
}

class UpdatedTransactionState extends TransactionState {
  @override
  List<Object?> get props => [];
}

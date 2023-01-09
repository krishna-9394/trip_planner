import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/transactions.dart';
import '../../data/services/transaction_services.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepo _transactionRepo = TransactionRepo();
  TransactionBloc() : super(InitializingTransactionState()) {
    on<InitializingTransactionBoxEvent>((event, emit) async {
      emit(InitializingTransactionState());
      await _transactionRepo.init();
      emit(InitializedTransactionState());
    });
    on<LoadTransactionListEvent>((event, emit) async {
      // TODO 4 reload the User end also
      emit(LoadingTransactionState());
      try {
        emit(LoadedTransactionState(
            size: await _transactionRepo.transactionListCount(), transactions: await _transactionRepo.getList()));
      } catch (error) {
        emit(FailedToLoadTransactionState(error: error as Error));
      }
    });
    on<AddTransactionEvent>((event, emit) async {
      try {
        await _transactionRepo.addTransaction(
            event.tripName, event.userName, event.note, event.amount, event.tripIndex);
        emit(AddedTransactionState());
      } catch (error) {
        // TODO add FailedTOAddTripState
        // emit(FailedToAddTripState(error: error as Error));
      }
    });
    on<DeleteTransactionEvent>((event, emit) async {
      try {
        await _transactionRepo.deleteTransaction(event.tripIndex, event.transactionIndex);
        emit(DeletedTransactionState());
      } catch (error) {
        // TODO add here also the above one
        // emit(FailedToDeleteTripState(error: error as Error));
      }
    });
    on<UpdateTransactionEvent>((event, emit) async {
      try {
        await _transactionRepo.updateTransaction(
            event.userName, event.note, event.amount, event.tripIndex, event.transactionIndex);
        emit(UpdatedTransactionState());
      } catch (error) {
        // TODO add here also the above one
        // emit(FailedToUpdateTripState(error: error as Error));
      }
    });
  }
}

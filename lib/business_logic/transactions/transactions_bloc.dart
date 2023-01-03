import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/Models/transaction.dart';
import '../../data/repositories/transaction_repositories.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  late TransactionRepo _transactionRepo;
  TransactionBloc() : super(TransactionInitialState()) {
    on<LoadTransactionListEvent>((event, emit) async {
      _transactionRepo = TransactionRepo();
      emit(TransactionInitialState());
      // TODO 4 reload the User end also
      await _transactionRepo.init();
      emit(TransactionLoadingState());
      try {
        emit(TransactionLoadedState(
            size: await _transactionRepo.transactionListCount(), transactions: await _transactionRepo.getList()));
      } catch (error) {
        print(error);
        emit(FailedToLoadTransactionState(error: error as Error));
      }
    });
    on<ReloadTransactionEvent>((event, emit) async {
      emit(TransactionLoadingState());
      try {
        emit(TransactionLoadedState(
          transactions: await _transactionRepo.getList(),
          size: await _transactionRepo.transactionListCount(),
        ));
      } catch (error) {
        print(error.toString());
        emit(FailedToLoadTransactionState(error: error as Error));
      }
    });
    on<AddTransactionEvent>((event, emit) async {
      try {
        await _transactionRepo.addTransaction(
            event.tripName, event.userName, event.note, event.amount, event.tripIndex, event.userIndex);
        emit(AddTransactionState());
        add(ReloadTransactionEvent(tripList: await _transactionRepo.getList()));
      } catch (error) {
        // TODO add FailedTOAddTripState
        // emit(FailedToAddTripState(error: error as Error));
      }
    });
    on<DeleteTransactionEvent>((event, emit) async {
      try {
        await _transactionRepo.deleteTransaction(event.tripIndex, event.transactionIndex, event.userIndex);
        emit(DeleteTransactionState());
        add(ReloadTransactionEvent(tripList: await _transactionRepo.getList()));
      } catch (error) {
        // TODO add here also the above one
        // emit(FailedToDeleteTripState(error: error as Error));
      }
    });
    on<UpdateTransactionEvent>((event, emit) async {
      try {
        await _transactionRepo.updateTransaction(
            event.userName, event.note, event.amount, event.tripIndex, event.transactionIndex, event.userIndex);
        emit(UpdateTransactionState());
        add(ReloadTransactionEvent(tripList: await _transactionRepo.getList()));
      } catch (error) {
        // TODO add here also the above one
        // emit(FailedToUpdateTripState(error: error as Error));
      }
    });
  }
}

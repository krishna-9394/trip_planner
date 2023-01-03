import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/transactions/transactions_bloc.dart';
import '../../../data/Models/transaction.dart';
import '../../../data/Models/user.dart';
import '../../../Transactions/TransactionUI.dart';
import 'TransactionUI.dart';

class TransactionList extends StatelessWidget {
  final String tripName;
  final int tripIndex;
  const TransactionList({super.key, required this.tripName, required this.tripIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc,TransactionState>(
        builder: (context,state){
          if(state is TransactionLoadingState){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is FailedToLoadTransactionState){
            return Center(
                child: Text("Failed to Load Transaction List \n ${state.error.toString()}",)
            );
          }
          else if(state is TransactionLoadedState){
            return Container(
              margin: const EdgeInsets.all(5),
              child: Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.size,
                  itemBuilder: (context, index) {
                    Transaction transaction = state.transactions.elementAt(index);
                    return TransactionUI(tripIndex: tripIndex, transactionIndex: index, userIndex: , transaction: transaction,);
                  },
                )
              ),
            );
          }
        }
    )
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/transaction/transaction_bloc.dart';
import '../../data/models/transactions.dart';
import '../../data/models/trips.dart';
import '../widgets/transaction_header.dart';
import '../widgets/transaction_ui.dart';

class TransactionPage extends StatelessWidget {
  final Trip trip;
  final int tripIndex;
  
  const TransactionPage({Key? key, required this.trip, required this.tripIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TransactionBloc>(context).add(LoadTransactionListEvent());
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      TransactionHeader(trip: trip, tripIndex: tripIndex),
      BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if(state is LoadingTransactionState){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is FailedToLoadTransactionState){
            return Center(
                child: Text("Failed to Load Transaction List \n ${state.error.toString()}",)
            );
          } else if(state is LoadedTransactionState){
            return Container(
              margin: const EdgeInsets.all(5),
              child: Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.size,
                  itemBuilder: (context, index) {
                    Transaction transaction = state.transactions.elementAt(index);
                    return TransactionUI(tripIndex: tripIndex, transactionIndex: index, transaction: transaction,);
                  },
                )
              ),
            );
          } else {
          return const Center(
                child: Text("There is no other state to load",)
            );
          }
        }
      )
    ]);
  }
}

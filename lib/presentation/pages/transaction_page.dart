import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/transaction/transaction_bloc.dart';
import '../../data/models/transactions.dart';
import '../../data/models/trips.dart';
import '../widgets/transaction_ui.dart';

class TransactionPage extends StatelessWidget {
  final Trip trip;
  final int tripIndex;

  const TransactionPage({Key? key, required this.trip, required this.tripIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TransactionBloc()..add(InitializingTransactionBoxEvent()),
        child: BlocBuilder<TransactionBloc, TransactionState>(builder: (context, state) {
          if (state is LoadingTransactionState) {
            return Stack(children: const [
              Center(
                child: CircularProgressIndicator(),
              )
            ]);
          } else if (state is FailedToLoadTransactionState) {
            return Stack(children: [
              Center(
                  child: Text(
                "Failed to Load Transaction List \n ${state.error.toString()}",
              ))
            ]);
          } else if (state is LoadedTransactionState) {
            if (state.transactions.isEmpty) {
              return Stack(children: [
                const Center(
                  child: Text(
                    "Transaction list is Empty",
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  margin: const EdgeInsets.only(bottom: 10, right: 10),
                  child: FloatingActionButton(
                    onPressed: () {},
                  ),
                ),
              ]);
            } else {
              print("we have reached this point");
              return Stack(children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.size,
                    itemBuilder: (context, index) {
                      Transaction transaction = state.transactions.elementAt(index);
                      return TransactionUI(
                        tripIndex: tripIndex,
                        transactionIndex: index,
                        transaction: transaction,
                      );
                    },
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  margin: const EdgeInsets.only(bottom: 10, right: 10),
                  child: FloatingActionButton(
                    onPressed: () {},
                  ),
                ),
              ]);
            }
          } else {
            return Stack(children: const [
              Center(
                child: Text(
                  "There is no other state to load",
                ),
              )
            ]);
          }
        }));
  }
}

import 'package:hive/hive.dart';

import '../../presentation/Widgets/constants.dart';
import '../Models/transaction.dart';
import '../Models/trip.dart';
import '../Models/user.dart';

class TransactionRepo {
  late Box<Transaction> _transactionBox;
  late Box<Trip> _tripBox;
  late Box<User> _userBox;
  Future<void> init() async {
    // registration of adapters and opening of the boxes
    _transactionBox = await Hive.openBox<Transaction>(Constants.transactionList);
    _tripBox = await Hive.openBox<Trip>(Constants.tripList);
    _userBox = await Hive.openBox<User>(Constants.userList);
  }

  Future<List<Transaction>> getList() async {
    List<Transaction> transaction = _transactionBox.values.toList();
    return transaction;
  }

  Future<int> transactionListCount() async {
    return _transactionBox.length;
  }

  Future<Transaction> getTransactionAt(int index) async {
    return _transactionBox.getAt(index) as Transaction;
  }

  Future<void> addTransaction(
      String tripName, String userName, String note, double amount, int tripIndex, int userIndex) async {
    await _transactionBox
        .add(Transaction(tripName: tripName, amount: amount, note: note, userName: userName, time: DateTime.now()));
    Trip trip = _tripBox.getAt(tripIndex) as Trip;
    User user = _userBox.getAt(userIndex) as User;
    user.paid += amount;
    trip.transactionsCount++;
    trip.totalAmount += amount;
    await _tripBox.putAt(tripIndex, trip);
    await _userBox.putAt(userIndex, user);
  }

  Future<void> updateTransaction(
      String userName, String note, double amount, int tripIndex, int transactionIndex, int userIndex) async {
    // update the amount / userName / note
    // TODO  add a option to add the custom date for the transaction
    Transaction transaction = _transactionBox.getAt(transactionIndex) as Transaction;
    Trip trip = _tripBox.getAt(tripIndex) as Trip;
    User user = _userBox.getAt(userIndex) as User;
    trip.totalAmount -= transaction.amount;
    user.paid -= transaction.amount;
    trip.totalAmount += amount;
    user.paid += amount;
    transaction.amount = amount;
    transaction.note = note;
    transaction.userName = userName;
    _tripBox.putAt(tripIndex, trip);
    _transactionBox.putAt(transactionIndex, transaction);
    _userBox.putAt(userIndex, user);
  }

  Future<void> deleteTransaction(int tripIndex, int transactionIndex, int userIndex) async {
    Trip trip = _tripBox.getAt(tripIndex) as Trip;
    User user = _userBox.getAt(userIndex) as User;
    Transaction transaction = _transactionBox.getAt(transactionIndex) as Transaction;
    user.paid -= transaction.amount;
    trip.totalAmount -= transaction.amount;
    trip.transactionsCount--;
    await _transactionBox.deleteAt(transactionIndex);
    await _tripBox.putAt(tripIndex, trip);
    await _userBox.putAt(userIndex, user);
  }
}

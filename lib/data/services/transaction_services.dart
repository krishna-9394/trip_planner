import 'package:hive/hive.dart';

import '../../presentation/constants.dart';
import '../models/transactions.dart';
import '../models/trips.dart';
import '../models/users.dart';

class TransactionRepo {
  late Box<Transaction> _transactionBox;
  late Box<Trip> _tripBox;
  Future<void> init() async {
    // registration of adapters and opening of the boxes
    _transactionBox = await Hive.openBox<Transaction>(Constants.transactionList);
    _tripBox = await Hive.openBox<Trip>(Constants.tripList);
  }

  Future<List<Transaction>> getList() async {
    final transaction = _transactionBox.values.toList();
    return transaction;
  }

  Future<int> transactionListCount() async {
    return _transactionBox.length;
  }

  Future<Transaction> getTransactionAt(int index) async {
    return _transactionBox.get(index)!;
  }

  Future<void> addTransaction(String tripName, String userName, String note, double amount, int tripIndex) async {
    await _transactionBox
        .add(Transaction(tripName: tripName, amount: amount, note: note, userName: userName, time: DateTime.now()));
    Trip trip = _tripBox.get(tripIndex)!;
    int userIndex = await indexOfUser(userName, tripIndex);
    trip.users[userIndex].paid += amount;
    trip.transactionsCount++;
    trip.totalAmount += amount;
    await _tripBox.put(tripIndex, trip);
  }

  Future<void> updateTransaction(
      String userName, String note, double amount, int tripIndex, int transactionIndex) async {
    // update the amount / userName / note
    // TODO 7 add a option to add the custom date for the transaction
    Transaction transaction = _transactionBox.get(transactionIndex)!;
    Trip trip = _tripBox.get(tripIndex)!;
    trip.totalAmount -= transaction.amount;
    int userIndex = await indexOfUser(transaction.userName, tripIndex);
    trip.users[userIndex].paid -= transaction.amount;
    trip.totalAmount += amount;
    trip.users[userIndex].paid += amount;
    transaction.amount = amount;
    transaction.note = note;
    transaction.userName = userName;
    await _tripBox.put(tripIndex, trip);
    await _transactionBox.put(transactionIndex, transaction);
  }

  Future<void> deleteTransaction(int tripIndex, int transactionIndex) async {
    Trip trip = _tripBox.get(tripIndex)!;
    Transaction transaction = _transactionBox.get(transactionIndex)!;
    int userIndex = await indexOfUser(transaction.userName, tripIndex);
    trip.users[userIndex].paid -= transaction.amount;
    trip.totalAmount -= transaction.amount;
    trip.transactionsCount--;
    await _transactionBox.delete(transactionIndex);
    await _tripBox.put(tripIndex, trip);
  }

  Future<bool> addUser(String tripName, String userName, double paid, int tripIndex) async {
    Trip trip = _tripBox.get(tripIndex)!;
    if (tripName.trim().compareTo('') == 0) return false;
    if (await search(tripName, tripIndex)) return false;
    User user = User(tripName: tripName, paid: paid, userName: userName);
    trip.users.add(user);
    trip.usersCount++;
    await _tripBox.put(tripIndex, trip);
    return true;
  }

  Future<bool> search(String name, int tripIndex) async {
    Trip trip = _tripBox.get(tripIndex)!;
    for (User user in trip.users) {
      if (user.tripName.compareTo(name) == 0) return false;
    }
    return true;
  }

  Future<int> indexOfUser(String name, int tripIndex) async {
    List<User> users = _tripBox.get(tripIndex)!.users;
    for (int i = 0; i < users.length; i++) {
      if (users.elementAt(i).userName.compareTo(name) == 0) return i;
    }
    return -1;
  }
}

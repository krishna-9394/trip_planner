import 'Transaction.dart';

class User {
  String _id;
  double _paid;
  double _balance;
  List<Transaction> _transaction = [];
  String _userName;
  String _imageResource;

  User(this._id,this._paid, this._balance, this._userName, this._imageResource);

  double get paid => _paid;
 String get id => _id;
  String get userName => _userName;

  List<Transaction> get transaction => _transaction;

  double get balance => _balance;

  String get imageResource => _imageResource;


  set setPaid(double value) => _paid = value;
  set setId(String id) => _id = id;
  set userName(String value) => _userName = value;

  set note(List<Transaction> value) => _transaction = value;

  set setBalance(double value) => _balance = value;

  set imageResource(String value) {
    _imageResource = value;
  }
}
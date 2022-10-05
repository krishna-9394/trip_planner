import 'Transaction.dart';

class User{
  int _id;
  int _balance;
  List<Transaction> _transaction =[];
  String _userName;
  String _gender;
  String _imageResource;
  User(this._id,this._balance,this._userName,this._gender,this._imageResource);

  int get id => _id;
  String get userName => _userName;
  List<Transaction> get transaction => _transaction;
  int get balance => _balance;
  String get imageResource => _imageResource;
  String get gender => _gender;

  set id(int value) => _id = value;
  set userName(String value) =>_userName = value;
  set note(List<Transaction> value) =>_transaction = value;
  set setBalance(int value) => _balance = value;
  set imageResource(String value) {
    _imageResource = value;
  }
  set gender(String value) {
    _gender = value;
  }

}
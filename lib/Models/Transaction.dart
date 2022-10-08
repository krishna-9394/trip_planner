class Transaction{
  String _id;
  int _amount;
  String _note;
  String _userName;
  DateTime _time;
  Transaction(this._id,this._amount,this._note,this._userName,this._time);

  String get id => _id;
  String get userName => _userName;
  String get note => _note;
  int get amount => _amount;
  DateTime get timming => _time;


  set setId(String id) =>_id = id;
  set userName(String value) =>_userName = value;
  set note(String value) =>_note = value;
  set amount(int value) => _amount = value;
  set timming(DateTime value) => _time = value;
}
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'Models/models.dart';
import 'Transactions/TransactionList.dart';
import 'Transactions/new_transaction.dart';
import 'Users/new_users.dart';
import 'Users/user_list.dart';
import 'Widgets/constants.dart';

class MainPage extends StatefulWidget {
  final String tripName;
  const MainPage(this.tripName, {super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Box usersBox, transactionBox;
  double totalAmount = 0;
  int usersCount = 0;
  int transactionCount = 0;
  bool _showUsers = false;

  @override
  void initState() {
    openBox();
    initialization();
    super.initState();
  }

  void initialization() async {
    usersCount = usersBox.length;
    transactionCount = transactionBox.length;
    for (int i = 0; i < usersBox.length; i++) {
      totalAmount += (transactionBox.getAt(i) as Transaction).amount;
    }
  }

  void openBox() {
    transactionBox = Hive.box<Transaction>(Constants.transactionList);
    usersBox = Hive.box<User>(Constants.userList);
  }

  bool isUserValid(String name) {
    for (int i = 0; i < usersBox.length; i++) {
      if ((usersBox.getAt(i) as User).userName.compareTo(name) == 0) return false;
    }
    return true;
  }

  void _addTransaction(String userName, String note, int amount) {
    transactionBox.add(
      Transaction(
        tripName: widget.tripName,
        amount: amount,
        note: note,
        userName: userName,
        time: DateTime.now(),
      ),
    );
    transactionCount++;
    totalAmount += amount;
    setState(() {});
  }

  void addUser(String userName) {
    usersBox.add(
      User(
        tripName: widget.tripName,
        paid: 0,
        userName: userName,
      ),
    );
    usersCount++;
    setState(() {});
  }

  void _deleteTransaction(int index) {
    totalAmount -= (transactionBox.getAt(index) as Transaction).amount;
    transactionBox.deleteAt(index);
    setState(() {});
  } // this is the function called from UserList => UserUI

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(widget.tripName),
      actions: [
        // this displays the Widgets at the Topright corner
        Container(
          padding: const EdgeInsets.all(5),
          child: Row(children: [
            (_showUsers) ? const Text("hide users list") : const Text("show users list"),
            Switch(
                onChanged: (val) {
                  setState(() {
                    _showUsers = val;
                  });
                },
                value: _showUsers),
            IconButton(
              icon: const Icon(Icons.analytics, color: Colors.white),
              onPressed: () {},
            ),
          ]),
        ),
      ],
    );
    double appBarHeight = appBar.preferredSize.height;
    double systemPadding = mediaQuery.padding.top + mediaQuery.padding.bottom;
    double mainScreenHeight = mediaQuery.size.height - appBarHeight - systemPadding;
    var userHeader = SizedBox(
      height: mainScreenHeight * 0.112,
      child: Card(
        elevation: 7.5,
        margin: const EdgeInsets.only(top: 10),
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: ListTile(
              title: const Text(
                "Users List",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ), // User List heading
              trailing: Ink(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: const CircleBorder(),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: ((builderContext) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {},
                                child: NewUser(
                                  isUserValid,
                                  addUser,
                                ),
                              );
                            }));
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      iconSize: 25,
                    ),
                  )),
            )),
      ),
    );
    var transactionHeader = SizedBox(
      height: mainScreenHeight * 0.112,
      child: Card(
        elevation: 7.5,
        margin: const EdgeInsets.only(top: 10),
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: ListTile(
              title: const Text(
                "Transactions List",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              trailing: Ink(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: const CircleBorder(),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: ((builderContext) {
                              return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {},
                                  child: NewTransaction(
                                    usersBox,
                                    _addTransaction,
                                    tripName: widget.tripName,
                                  ));
                            }));
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      iconSize: 25,
                    ),
                  )),
            )),
      ),
    );
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
          appBar: appBar,
          body: Column(
            children: [
              transactionHeader,
              Expanded(
                child: SizedBox(
                  height: _showUsers ? (mainScreenHeight * 0.348) : (mainScreenHeight * 0.888),
                  child: SingleChildScrollView(
                    child: TransactionList(
                      _deleteTransaction,
                      transactionBox,
                      tripName: widget.tripName,
                    ),
                  ),
                ),
              ),
              _showUsers ? userHeader : const SizedBox(height: 0),
              _showUsers
                  ? Expanded(
                      child: SizedBox(
                      height: mainScreenHeight * 0.427,
                      child: SingleChildScrollView(
                        child: UserList(
                          usersBox,
                          totalAmount,
                          tripName: widget.tripName,
                        ),
                      ),
                    ))
                  : const Expanded(
                      child: SizedBox(
                        height: 0,
                      ),
                    ),
            ],
          )

          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          // floatingActionButton: FloatingActionButton(
          //   child: const Icon(Icons.add,),
          //   onPressed: (){
          //     showModalBottomSheet(context: context, builder: ((builderContext){
          //       return NewTransaction(_addTransaction,_userList);
          //     }));
          //   },
          // )
          ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../data/Models/user.dart';

class mainPage extends StatelessWidget {
  final Trip trip;
  final int index;
  const mainPage({super.key, required this.trip, required this.index});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // double appBarHeight = appBar.preferredSize.height;
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
                                child: NewUser(trip: trip, tripIndex: index),
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
                                  behavior: HitTestBehavior.opaque, onTap: () {}, child: const NewTransaction());
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
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(trip.tripName),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Icon(Icons.people_alt_sharp),
                Icon(Icons.currency_rupee_sharp),
              ],
            ),
            actions: [
              // this displays the Widgets at the top right corner
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Switch(
                        onChanged: (val) {
                          // setState(() {
                          //   _showUsers = val;
                          // });
                        },
                        value: true),
                  ],
                ),
              ),
            ],
          ),
          body: TabBarView(
            children: [],
          )),
    );
  }
}

//
class MainPage extends StatefulWidget {
  final String tripName;
  const MainPage(this.tripName, {super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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

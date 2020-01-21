import 'package:flutter/material.dart';
import 'package:ims/Database/UserData.dart';
import 'package:ims/Database/databaseDAO.dart';
import 'package:ims/Screen/addProduct.dart';
import 'package:ims/Screen/infoAd.dart';
import 'package:ims/main.dart';

class Staff extends StatefulWidget {
  @override
  _StaffState createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  DatabaseDAO databaseDAO = DatabaseDAO();
  List<UserData> userData;
  getUserData() async {
    List _userData = await databaseDAO.getAllSortedByID();
    setState(() {
      userData = _userData;
    });
  }

  initState() {
    super.initState();
    getUserData();
  }

  Column _bottomMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text(
            userData[0].name,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          title: Text(
            userData[0].mobile,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.highlight_off),
              onPressed: () {
                databaseDAO.deleteAll();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
              },
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useRootNavigator: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
                  builder: (context) {
                    return Container(
                      child: _bottomMenu(),
                    );
                  });
            },
          ),
          title: Text('Staff'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Info'),
              Tab(text: 'Add'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            InfoAd(),
            AddProduct(),
          ],
        ),
      ),
    );
  }
}

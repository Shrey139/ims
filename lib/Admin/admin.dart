import 'package:flutter/material.dart';
import 'package:ims/Admin/AddUser.dart';
import 'package:ims/Admin/manageUser.dart';
import 'package:ims/Admin/stats.dart';
import 'package:ims/Database/databaseDAO.dart';
import 'package:ims/Screen/addProduct.dart';
import 'package:ims/Screen/infoAd.dart';
import 'package:ims/main.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  DatabaseDAO databaseDAO = DatabaseDAO();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
          title: Text('Admin Panel'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Info'),
              Tab(text: 'Add'),
              Tab(text: 'Stats'),
              Tab(text: 'Adding User'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            InfoAd(),
            AddProduct(),
            Stats(),
            AddUser(),
          ],
        ),
      ),
    );
  }
}

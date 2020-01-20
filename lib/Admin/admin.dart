import 'package:flutter/material.dart';
import 'package:ims/Admin/manageUser.dart';
import 'package:ims/Admin/stats.dart';
import 'package:ims/Screen/addProduct.dart';
import 'package:ims/Screen/infoAd.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Panel'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Info'),
              Tab(text: 'Add'),
              Tab(text: 'Stats'),
              Tab(text: 'Manage User'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            InfoAd(),
            AddProduct(),
            Stats(),
            ManageUser(),
          ],
        ),
      ),
    );
  }
}

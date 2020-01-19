import 'package:flutter/material.dart';
import 'package:ims/Screen/infoAd.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Panel'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Info'),
              Tab(text: 'Add Product'),
              Tab(text: 'Manage User'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            InfoAd(),
            Center(child: Text('Add Product')),
            Center(child: Text('Manage User')),
          ],
        ),
      ),
    );
  }
}

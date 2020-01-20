import 'package:flutter/material.dart';
import 'package:ims/Screen/addProduct.dart';
import 'package:ims/Screen/bill.dart';
import 'package:ims/Screen/infoAd.dart';

class Staff extends StatefulWidget {
  @override
  _StaffState createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Staff'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Info'),
              Tab(text: 'Bill'),
              Tab(text: 'Add'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            InfoAd(),
            Bill(),
            AddProduct(),
          ],
        ),
      ),
    );
  }
}

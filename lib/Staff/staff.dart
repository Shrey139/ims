import 'package:flutter/material.dart';
import 'package:ims/Screen/bill.dart';
import 'package:ims/Screen/info.dart';

class Staff extends StatefulWidget {
  @override
  _StaffState createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Staff'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Info'),
              Tab(text: 'Bill'),
              Tab(text: 'Add'),
              Tab(text: 'Remove'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Info(),
            Bill(),
            Center(
              child: Text('Add'),
            ),
            Center(
              child: Text('Remove'),
            ),
          ],
        ),
      ),
    );
  }
}

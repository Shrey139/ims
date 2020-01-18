import 'package:flutter/material.dart';
import 'package:ims/Login/adminLogin.dart';
import 'package:ims/Login/staffLogin.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Staff',
                  icon: Icon(Icons.person),
                ),
                Tab(
                  text: 'Admin',
                  icon: Icon(Icons.person_add),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            StaffLogin(),
            AdminLogin(),
          ],
        ),
      ),
    );
  }
}

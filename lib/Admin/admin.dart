import 'package:flutter/material.dart';
import 'package:ims/Admin/AddUser.dart';
import 'package:ims/Admin/manageUser.dart';
import 'package:ims/Admin/stats.dart';
import 'package:ims/Database/databaseDAO.dart';
import 'package:ims/Screen/addProduct.dart';
import 'package:ims/Screen/infoAd.dart';
import 'package:ims/main.dart';
import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  DatabaseDAO databaseDAO = DatabaseDAO();
  int selectedPos = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FancyBottomBar(
        items: [
          FancyBottomItem(
          title: Text(
            "Info",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          icon: Icon(Icons.info)),
          FancyBottomItem(
          title: Text(
            "Add",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          icon: Icon(Icons.add)),
          FancyBottomItem(
          title: Text(
            "Stats",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          icon: Icon(Icons.graphic_eq)),
          FancyBottomItem(
          title: Text(
            "Add User",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          icon: Icon(Icons.person_add)),
        ],
        selectedPosition: selectedPos,
        onItemSelected: (i) => setState(() => selectedPos = i),
        selectedColor: Theme.of(context).accentColor,
        indicatorColor: Theme.of(context).accentColor,
        elevation: 2.0,
      ),
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
      ),
      body: getScreen(selectedPos),
    );
  }
   getScreen(int position) {
    if (position == 0) {
      return InfoAd();
    }
    if (position == 1) {
      return AddProduct();
    }
    if (position == 2) {
      return Stats();
    }
    if (position == 3) {
      return AddUser();
    }
  }
}

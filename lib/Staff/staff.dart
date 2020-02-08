import 'package:flutter/material.dart';
import 'package:ims/Database/UserData.dart';
import 'package:ims/Database/databaseDAO.dart';
import 'package:ims/Screen/addProduct.dart';
import 'package:ims/Screen/infoAd.dart';
import 'package:ims/main.dart';
import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';

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
  int selectedPos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: FancyBottomBar(
        items: [
          FancyBottomItem(
            title: Text(
              "Add",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            icon: Icon(Icons.add)),
        FancyBottomItem(
            title: Text(
              "Info",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            icon: Icon(Icons.info)),
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
  }
}

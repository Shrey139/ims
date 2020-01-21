import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ims/Admin/admin.dart';
import 'package:ims/Database/UserData.dart';
import 'package:ims/Login/login.dart';
import 'package:ims/Staff/staff.dart';
import 'Database/databaseDAO.dart';
import 'Screen/info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  DatabaseDAO databaseDAO = DatabaseDAO();
  List<UserData> userData;
  checkLogin() async {
    List _userData = await databaseDAO.getAllSortedByID();
    setState(() {
      userData = _userData;
      isLoading = false;
    });
    if (userData[0].role == 'staff') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Staff(),
          ));
    } else if (userData[0].role == 'admin') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Admin(),
          ));
    }
  }

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMS'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ));
            },
          ),
        ],
      ),
      body: Info(),
    );
  }
}

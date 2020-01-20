import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ims/Admin/admin.dart';
import 'package:ims/Config.dart';
import 'package:ims/Database/UserData.dart';
import 'package:ims/Database/databaseDAO.dart';
import 'package:ims/Staff/staff.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  DatabaseDAO databaseDAO = DatabaseDAO();
  String username;
  String password;

  _login() async {
    setState(() {
      username = _userController.text;
      password = _passController.text;
    });

    Map<String, String> header = {"Content-type": "application/json"};
    String json =
        '{"username": "' + username + '", "password": "' + password + '"}';
    Response response = await post(loginUrl, headers: header, body: json);
    print(response.body);
    var data = jsonDecode(response.body);
    databaseDAO.insert(UserData(
      name: data['data']['name'],
      mobile: data['data']['mobileNumber'],
      role: data['data']['role'],
      token: data['data']['token'],
    ));
    if (data['data']['role'] == 'staff') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Staff(),
          ));
    } else if (data['data']['role'] == 'admin') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Admin(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('asset/image/background.jpg'),
            fit: BoxFit.fitHeight),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      validator: (_userController) {
                        if (_userController.isEmpty) {
                          return 'Enter Username';
                        } else {
                          return null;
                        }
                      },
                      controller: _userController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          labelText: 'Username',
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.all(20),
                          prefixIcon: Icon(Icons.person_outline)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (_passController) {
                        if (_passController.isEmpty) {
                          return 'Enter Password';
                        } else {
                          return null;
                        }
                      },
                      controller: _passController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        labelText: 'Password',
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(20),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(10),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          print('done');
                        } else {
                          print('not done');
                        }
                        _login();
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text('Forget Password'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

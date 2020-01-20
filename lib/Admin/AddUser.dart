import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ims/Config.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _sname = TextEditingController();
  TextEditingController _sphone = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  String name, phone, username, password;
  Future<void> addUser() async {
    setState(() {
      name = _sname.text;
      phone = _sphone.text;
      username = _username.text;
      password = _password.text;
    });
    Map<String, String> header = {"Content-type": "application/json"};
    String json = '{"name": "' +
        name +
        '", "phoneNumber": "' +
        phone +
        '", "username": "' +
        username +
        '", "password": "' +
        password +
        '"}';
    Response response = await post(signupURL, headers: header, body: json);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      validator: (_sname) {
                        if (_sname.isEmpty) {
                          return 'Enter Staff Name';
                        } else {
                          return null;
                        }
                      },
                      controller: _sname,
                      decoration: InputDecoration(
                        labelText: 'Name:',
                      ),
                    ),
                    TextFormField(
                      validator: (_phone) {
                        if (_phone.isEmpty) {
                          return 'Enter Phone';
                        } else {
                          return null;
                        }
                      },
                      controller: _sphone,
                      decoration: InputDecoration(
                        labelText: 'Phone:',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      validator: (_username) {
                        if (_username.isEmpty) {
                          return 'Enter Username';
                        } else {
                          return null;
                        }
                      },
                      controller: _username,
                      decoration: InputDecoration(
                        labelText: 'Username:',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      validator: (_password) {
                        if (_password.isEmpty) {
                          return 'Enter Password';
                        } else {
                          return null;
                        }
                      },
                      controller: _password,
                      decoration: InputDecoration(
                        labelText: 'Password:',
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.number,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          addUser();
                        } else {
                          print('not done');
                        }
                      },
                      child: Text('Add Staff'),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
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

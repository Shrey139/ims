import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ims/Admin/admin.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String username;
  String password;

  _login() {
    setState(() {
      username = _userController.text;
      password = _passController.text;
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Admin(),
        ));
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
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
                  TextField(
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
                    onPressed: () => _login(),
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
    );
  }
}

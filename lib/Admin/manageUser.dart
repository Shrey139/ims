import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ManageUser extends StatefulWidget {
  @override
  _ManageUserState createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  var url = 'https://randomuser.me/api/';
  getData() async {
    var response = await http.post(url, body: {'gender': 'female'});
    print(response.body);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.person_add),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Full name'),
            subtitle: Text('Email'),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle_outline),
              color: Colors.red,
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}

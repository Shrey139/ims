import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String result;
  _scan() async {
    String _result = await scanner.scan();
    setState(() {
      result = _result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _scan,
          tooltip: 'Scan',
          child: Icon(Icons.camera),
        ),
        body: Center(child: result != null ? Text(result) : Text("")));
  }
}

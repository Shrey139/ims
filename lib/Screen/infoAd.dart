import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class InfoAd extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<InfoAd> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Card(
              margin: EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Product Name: '),
                      initialValue: 'Parle G',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Price: '),
                      initialValue: '20 Rs',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'MGF: '),
                      initialValue: '20-08-2019',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Expire: '),
                      initialValue: '31-12-2020',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Product Name: '),
                      initialValue: 'Parle G',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Price: '),
                      initialValue: '20 Rs',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'MGF: '),
                      initialValue: '20-08-2019',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Expire: '),
                      initialValue: '31-12-2020',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Product Name: '),
                      initialValue: 'Parle G',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Price: '),
                      initialValue: '20 Rs',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'MGF: '),
                      initialValue: '20-08-2019',
                      readOnly: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Expire: '),
                      initialValue: '31-12-2020',
                      readOnly: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {},
                            child: Text('Update'),
                            textColor: Colors.white,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text('Remove'),
                            textColor: Colors.white,
                            color: Colors.red,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      //Center(child: result != null ? Text(result) : Text("")),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:expandable/expandable.dart';

class Bill extends StatefulWidget {
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {
  _scan() async {
    String _result = await scanner.scan();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _scan,
        tooltip: 'Scan',
        child: Icon(Icons.camera),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandablePanel(
                header: Text('Product Name'),
                collapsed: Text(
                  'Price',
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  children: <Widget>[
                    Text('Msg Date: '),
                    Text('Price: '),
                    Text('Etc: '),
                    Text('Etc 1: '),
                  ],
                ),
                tapHeaderToExpand: true,
                hasIcon: true,
              ),
            ),
          );
        },
      ),
    );
  }
}

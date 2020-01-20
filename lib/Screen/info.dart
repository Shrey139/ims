import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ims/Config.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool isLoading = false;
  String result;
  var response;
  String name;

  _scan() async {
    String _result = await scanner.scan();
    setState(() {
      result = _result;
      isLoading = true;
    });
    var res = await http.get(
      Uri.encodeFull(productDetails + result),
    );
    print(res.body);
    setState(() {
      print('inside setSatet');
      response = res.body;
      name = response.data['productName'];
      isLoading = false;
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
          child: result == null
              ? Center(
                  child: Text('Scan to See Data'),
                )
              : SingleChildScrollView(
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
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
                                    decoration: InputDecoration(
                                        labelText: 'Product Name: '),
                                    initialValue: response.data['productName'],
                                    readOnly: true,
                                  ),
                                  // TextFormField(
                                  //   decoration:
                                  //       InputDecoration(labelText: 'Price: '),
                                  //   initialValue: response['data']['product']
                                  //       ['price'],
                                  //   readOnly: true,
                                  // ),
                                  // TextFormField(
                                  //   decoration: InputDecoration(
                                  //       labelText: 'Quantity: '),
                                  //   initialValue: response['data'][0]['product']
                                  //       ['quantity'],
                                  //   readOnly: true,
                                  // ),
                                  // TextFormField(
                                  //   decoration:
                                  //       InputDecoration(labelText: 'Type: '),
                                  //   initialValue: response['data'][0]['product']
                                  //       ['type'],
                                  //   readOnly: true,
                                  // ),
                                  // TextFormField(
                                  //   decoration: InputDecoration(
                                  //       labelText: 'Purchase Date: '),
                                  //   initialValue: response[0]['data']['product']
                                  //       ['purchaseDate'],
                                  //   readOnly: true,
                                  // ),
                                  // TextFormField(
                                  //   decoration: InputDecoration(
                                  //       labelText: 'Expiry Date: '),
                                  //   initialValue: response[0]['data']['product']
                                  //       ['expiryDate'],
                                  //   readOnly: true,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
        ));
  }
}

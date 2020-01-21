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
    setState(() {
      response = jsonDecode(res.body);
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
                                    initialValue: response['data']
                                            ['productName']
                                        .toString(),
                                    readOnly: true,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Price: '),
                                    initialValue:
                                        response['data']['price'].toString(),
                                    readOnly: true,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Quantity: '),
                                    initialValue:
                                        response['data']['quantity'].toString(),
                                    readOnly: true,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Type: '),
                                    initialValue:
                                        response['data']['type'].toString(),
                                    readOnly: true,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Purchase Date: '),
                                    initialValue: response['data']
                                            ['purchaseDate']
                                        .toString(),
                                    readOnly: true,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Expiry Date: '),
                                    initialValue: response['data']['expiryDate']
                                        .toString(),
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
        ));
  }
}

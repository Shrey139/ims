import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ims/Database/UserData.dart';
import 'package:ims/Database/databaseDAO.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;

import '../Config.dart';

class InfoAd extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<InfoAd> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _price = TextEditingController();
  TextEditingController _quatity = TextEditingController();
  bool isLoading = false;
  String result;
  var response;
  String name;
  String price, quatity;

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
      price = _price.text;
      quatity = _quatity.text;
      isLoading = false;
    });
  }

  String token;

  List<UserData> userData;
  DatabaseDAO databaseDAO = DatabaseDAO();
  initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    List _userData = await databaseDAO.getAllSortedByID();
    setState(() {
      userData = _userData;
    });
    token = userData[0].token;
  }

  updateProduct() async {
    Map<String, String> header = {"Content-type": "application/json"};
    String json = '{"price": "' +
        price +
        '", "quantity": "' +
        quatity +
        '", "token": "' +
        token +
        '"}';
    Response response = await put(addProduct, headers: header, body: json);
    var res = jsonDecode(response.body);
    if (res['status'] == 'success') {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Data Updated Succesfully'),
        duration: Duration(seconds: 2),
      ));
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Update Failed'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  removeProduct() async {
    int id = userData[0].id;
    Map<String, String> header = {"Content-type": "application/json"};
    String json = '{"id": "' + id.toString() + '", "token": "' + token + '"}';
    Response response = await post(removeProd, headers: header, body: json);
    var res = jsonDecode(response.body);
    if (res['status'] == 'success') {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Removed Succesfully'),
        duration: Duration(seconds: 2),
      ));
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Failed to Remove'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  dispactProduct() async {
    int id = userData[0].id;
    Map<String, String> header = {"Content-type": "application/json"};
    String json = '{"id": "' + id.toString() + '", "token": "' + token + '"}';
    Response response = await put(dispactProd, headers: header, body: json);
    var res = jsonDecode(response.body);
    if (res['status'] == 'success') {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Dispatch Succesfully'),
        duration: Duration(seconds: 2),
      ));
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Failed to Dispatch'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                                  initialValue: response != null
                                      ? response['data']['productName']
                                          .toString()
                                      : '',
                                  readOnly: true,
                                ),
                                TextFormField(
                                  //controller: _price,
                                  decoration:
                                      InputDecoration(labelText: 'Price: '),
                                  initialValue: response != null
                                      ? response['data']['price'].toString()
                                      : '',
                                ),
                                TextFormField(
                                  // controller: _quatity,
                                  decoration:
                                      InputDecoration(labelText: 'Quantity: '),
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
                                  initialValue: response['data']['purchaseDate']
                                      .toString(),
                                  readOnly: true,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Expiry Date: '),
                                  initialValue:
                                      response['data']['expiryDate'].toString(),
                                  readOnly: true,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      RaisedButton(
                                        onPressed: () {
                                          updateProduct();
                                        },
                                        child: Text('Update'),
                                        textColor: Colors.white,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          removeProduct();
                                        },
                                        child: Text('Remove'),
                                        textColor: Colors.white,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          dispactProduct();
                                        },
                                        child: Text('Dispatch'),
                                        textColor: Colors.white,
                                        color: Colors.green,
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
    );
  }
}

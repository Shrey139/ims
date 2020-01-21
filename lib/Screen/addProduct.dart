import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ims/Config.dart';
import 'package:ims/Database/UserData.dart';
import 'package:ims/Database/databaseDAO.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _pname = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _expireDate = TextEditingController();
  TextEditingController _quatity = TextEditingController();
  List<UserData> userData;
  DatabaseDAO databaseDAO = DatabaseDAO();
  String _type;
  String pname, price, expireDate, quatity;
  var res;
  submit() async {
    isLoading = true;
    List _userData = await databaseDAO.getAllSortedByID();
    setState(() {
      userData = _userData;
      isLoading = false;
    });
    String token = userData[0].token;
    pname = _pname.text;
    price = _price.text;
    expireDate = _expireDate.text;
    quatity = _quatity.text;
    Map<String, String> header = {"Content-type": "application/json"};
    String json = '{"productName": "' +
        pname +
        '", "price": "' +
        price +
        '", "quantity": "' +
        quatity +
        '", "type": "' +
        _type +
        '", "expiryDate": "' +
        expireDate +
        '", "token": "' +
        token +
        '"}';
    Response response = await post(addProduct, headers: header, body: json);
    print(response.body);
    res = jsonDecode(response.body);
    print(res['data']['id']);
    String id = res['data']['id'];
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (context) {
          return Container(
            child: _bottomMenu(id),
          );
        });
  }

  Column _bottomMenu(String id) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: QrImage(
              data: id,
              version: QrVersions.auto,
              size: 320,
              gapless: false,
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(50, 50),
              ),
            ),
          ),
        ),
        Text('Scan QR code'),
        SizedBox(
          height: 5.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Card(
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
                            validator: (_pname) {
                              if (_pname.isEmpty) {
                                return 'Enter Product Name';
                              } else {
                                return null;
                              }
                            },
                            controller: _pname,
                            decoration: InputDecoration(
                              labelText: 'Product Name:',
                            ),
                          ),
                          TextFormField(
                            validator: (_price) {
                              if (_price.isEmpty) {
                                return 'Enter Product Price';
                              } else {
                                return null;
                              }
                            },
                            controller: _price,
                            decoration: InputDecoration(
                              labelText: 'Price:',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          DateTimeField(
                            controller: _expireDate,
                            format: format,
                            decoration:
                                InputDecoration(labelText: 'Expiry Date'),
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2019),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(3000));
                              print(date);
                              return date;
                            },
                          ),
                          TextFormField(
                            validator: (_quanity) {
                              if (_quanity.isEmpty) {
                                return 'Enter Product Quantity';
                              } else {
                                return null;
                              }
                            },
                            controller: _quatity,
                            decoration: InputDecoration(
                              labelText: 'Quantity:',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          DropdownButton<String>(
                            hint: _type != null
                                ? Text(_type)
                                : Text('Select Type'),
                            items: <String>[
                              'Food',
                              'Electronic',
                              'Cloths',
                              'Furniture',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _type = value;
                              });
                            },
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                print('done');
                                submit();
                              } else {
                                print('not done');
                              }
                            },
                            child: Text('Generate QR'),
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

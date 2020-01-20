import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _pname = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _expireDate = TextEditingController();
  TextEditingController _quatity = TextEditingController();
  // TextEditingController _type = TextEditingController();
  String _type;

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
                      decoration: InputDecoration(labelText: 'Expiry Date'),
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
                      hint: _type != null ? Text(_type) : Text('Select Type'),
                      items: <String>[
                        'Food Product',
                        'XYZ Product',
                        'XYZ Product 2'
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

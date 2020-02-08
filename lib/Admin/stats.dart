import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:http/http.dart';
import 'package:ims/Config.dart';
import 'package:ims/Database/UserData.dart';
import 'package:ims/Database/databaseDAO.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List<UserData> userData;
  DatabaseDAO databaseDAO = DatabaseDAO();
  // double dispachedLength = 2;
  // double expiryLength = 2;
  // double noProducts = 2;
  // double lowStockProduct = 2;
  getStats() async {
    List _userData = await databaseDAO.getAllSortedByID();
    setState(() {
      userData = _userData;
    });
    String token = userData[0].token;
    Map<String, String> header = {"Content-type": "application/json"};
    String json = '{"token": "' + token + '"}';
    Response response = await post(statsurl, headers: header, body: json);
    print(response.body);
    var data = jsonDecode(response.body);
    setState(() {
      // dispachedLength = data['dispachedToday'];
      // expiryLength = data['expiringProducts'];
      // noProducts = data['noOfProducts'];
      // lowStockProduct = data['lowStockProduct'];
      // _seriesPieData = List<chart.Series<Task, String>>();
      // generateData();
    });
  }

  List<chart.Series<Task, String>> _seriesPieData;

  generateData() {
    var pieData = [
      Task('About to Expire', 5, Colors.blue),
      Task('Dispached', 3, Colors.red),
    ];

    _seriesPieData.add(
      chart.Series(
        data: pieData,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskValue,
        colorFn: (Task task, _) => chart.ColorUtil.fromDartColor(task.colorval),
        id: 'Daily Task',
        labelAccessorFn: (Task row, _) => '${row.taskValue}',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getStats();
    _seriesPieData = List<chart.Series<Task, String>>();
    generateData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 4;
    var width = MediaQuery.of(context).size.width / 2.2;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //         colors: [Color(0xFF00f260), Color(0xFF057e6)])),
                  height: height,
                  width: width,
                  child: Card(
                    // color: Colors.transparent,
                    margin: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text('Today'),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '3',
                                  style: TextStyle(fontSize: 100.0),
                                ),
                              ),
                            ),
                            Text('Dispatch Product'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //         colors: [Color(0xFF00f260), Color(0xFF057e6)])),
                  height: height,
                  width: width,
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text('     '),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '10',
                                  style: TextStyle(fontSize: 100.0),
                                ),
                              ),
                            ),
                            Text('Total Product'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 300,
            child: chart.PieChart(
              _seriesPieData,
              animate: true,
              animationDuration: Duration(seconds: 1),
              behaviors: [
                chart.DatumLegend(
                  outsideJustification:
                      chart.OutsideJustification.middleDrawArea,
                  horizontalFirst: true,
                  position: chart.BehaviorPosition.bottom,
                  desiredMaxRows: 2,
                  cellPadding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                  entryTextStyle: chart.TextStyleSpec(
                      color: chart.MaterialPalette.purple.shadeDefault,
                      fontSize: 14),
                )
              ],
              defaultRenderer: chart.ArcRendererConfig(
                  arcWidth: 80,
                  arcRendererDecorators: [
                    chart.ArcLabelDecorator(
                        labelPosition: chart.ArcLabelPosition.inside)
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class Task {
  Task(this.task, this.taskValue, this.colorval);

  Color colorval;
  String task;
  double taskValue;
}

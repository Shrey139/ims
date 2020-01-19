import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart;

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List<chart.Series<Task, String>> _seriesPieData;

  generateData() {
    var pieData = [
      Task('Work', 20, Colors.blue),
      Task('Time', 10, Colors.red),
      Task('Year', 18, Colors.yellow),
      Task('Minute', 5, Colors.orange),
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
    _seriesPieData = List<chart.Series<Task, String>>();
    generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: chart.PieChart(
        _seriesPieData,
        animate: true,
        animationDuration: Duration(seconds: 5),
        // behaviors: [
        //   chart.DatumLegend(
        //     outsideJustification: chart.OutsideJustification.endDrawArea,
        //     horizontalFirst: false,
        //     desiredMaxRows: 2,
        //     cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
        //     entryTextStyle: chart.TextStyleSpec(
        //         color: chart.MaterialPalette.purple.shadeDefault, fontSize: 11),
        //   )
        // ],
        defaultRenderer:
            chart.ArcRendererConfig(arcWidth: 100, arcRendererDecorators: [
          chart.ArcLabelDecorator(labelPosition: chart.ArcLabelPosition.inside)
        ]),
      ),
    );
  }
}

class Task {
  String task;
  double taskValue;
  Color colorval;
  Task(this.task, this.taskValue, this.colorval);
}

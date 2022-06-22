import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPageState();

}

class _DashboardPageState extends State<DashboardPage> {
  late List<ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25, Colors.black),
      ChartData('Steve', 38, Colors.red),
      ChartData('Jack', 34, Colors.grey),
      ChartData('Others', 52, Colors.blue)
    ];
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCircularChart(
                    series: <CircularSeries>[
                      // Render pie chart
                      PieSeries<ChartData, String>(
                          dataSource: chartData,
                          pointColorMapper:(ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y
                      )
                    ]
                )
            )
        )
    );
  }

}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
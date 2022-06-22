import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:todo_app/themes.dart';

import '../main.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<ChartData> data;
  late TooltipBehavior _tooltip;
  TextEditingController startDate = TextEditingController(
      text: DateFormat("yyyy-mm-dd").format(DateTime.now()));
  TextEditingController endDate = TextEditingController(
      text: DateFormat("yyyy-mm-dd")
          .format(DateTime.now().add(Duration(days: 1))));

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Complete', 25, Colors.yellow),
      ChartData('Yet To Start', 38, Colors.yellow.shade200),
      ChartData('In Progress', 34, Colors.yellow.shade100),
      ChartData('Cancelled', 52, Colors.yellow.shade900)
    ];

    final dateStyle = TextStyle(fontSize: 20, color: Colors.grey.shade500);
    const dateIcon = Icon(
      Icons.calendar_today_rounded,
      size: 20,
      color: JTThemes.primaryColor,
    );

    return ThemeSwitchingArea(
        child: Builder(
            builder: (context) => Scaffold(
                    body: Column(children: <Widget>[
                  const Text(
                    "Status Breakdown",
                    style:
                        TextStyle(fontSize: 30, color: JTThemes.primaryColor),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Row(children: [
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(
                        child: TextFormField(
                      controller: startDate,
                      style: dateStyle,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        isDense: true,
                        border: OutlineInputBorder(borderSide: BorderSide(color: JTThemes.primaryColor)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: JTThemes.primaryColor)),
                        labelText: 'Start Date',
                        labelStyle: TextStyle(color: JTThemes.primaryColor),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        //icon: dateIcon,
                        suffixIcon: dateIcon,
                        //suffixIconConstraints: BoxConstraints(maxWidth: 10, maxHeight: 10)
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(Duration(days: 365 * 5)),
                            lastDate: DateTime.now());
                        if (pickedDate != null) {
                          //logger.d(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat("yyyy-mm-dd").format(pickedDate);
                          log.d(formattedDate);
                          //you can implement different kind of Date Format here according to your requirement
                          setState(() {
                            startDate.text = formattedDate;
                          });
                        } else {
                          log.d("Date is not selected");
                        }
                      },
                    )),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    Expanded(
                        child: TextFormField(
                      controller: endDate,
                      style: dateStyle,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        isDense: true,
                        border: OutlineInputBorder(borderSide: BorderSide(color: JTThemes.primaryColor)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: JTThemes.primaryColor)),
                        //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: JTThemes.primaryColor)),
                        labelText: 'End Date',
                        labelStyle: TextStyle(color: JTThemes.primaryColor),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        //icon: dateIcon,
                        suffixIcon: dateIcon,
                        //suffixIconConstraints: BoxConstraints(maxWidth: 10, maxHeight: 10)
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(Duration(days: 365 * 5)),
                            lastDate: DateTime.now());
                        if (pickedDate != null) {
                          //logger.d(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat("yyyy-mm-dd").format(pickedDate);
                          log.d(formattedDate);
                          //you can implement different kind of Date Format here according to your requirement
                          setState(() {
                            endDate.text = formattedDate;
                          });
                        } else {
                          log.d("Date is not selected");
                        }
                      },
                    )),
                    Padding(padding: EdgeInsets.only(left: 10)),
                  ]),
                  Padding(
                    padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: JTThemes.primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                          //height: 200,
                          child: SfCircularChart(
                            series: <CircularSeries>[
                              // Render pie chart
                              PieSeries<ChartData, String>(
                                  dataSource: chartData,
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y)
                            ],
                            legend: Legend(
                              isVisible: true,
                              width: '100%',
                              textStyle: TextStyle(fontSize: 15),
                            ),
                            //title: ChartTitle(text: "ToDo Status", textStyle: TextStyle(fontSize: 30, color: JTThemes.primaryColor)),
                            //legend: Legend(title: LegendTitle(text: "something")),
                            tooltipBehavior: TooltipBehavior(enable: true),
                          )))
                ]))));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}

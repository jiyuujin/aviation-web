import 'package:aviation_web/pages/chart_container.dart';
import 'package:aviation_web/services/flight.service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AirlineChartCard extends StatelessWidget {
  const AirlineChartCard({Key? key, required this.documents}) : super(key: key);

  final dynamic documents;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(4),
        color: Colors.blue[100],
        shadowColor: Colors.blueGrey,
        elevation: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ChartContainer(
                title: 'Airline',
                color: const Color(0x00000000),
                chart: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: generateData(documents, 0),
                        title: 'JAL',
                        color: const Color.fromARGB(255, 237, 63, 86),
                      ),
                      PieChartSectionData(
                        value: generateData(documents, 1),
                        title: 'ANA',
                        color: const Color.fromARGB(255, 63, 78, 237),
                      ),
                      PieChartSectionData(
                        value: generateData(documents, 2),
                        title: 'SKY',
                        color: const Color.fromARGB(255, 237, 234, 63),
                      ),
                      PieChartSectionData(
                        value: generateData(documents, 3),
                        title: 'SFJ',
                        color: const Color.fromARGB(255, 5, 5, 1),
                      ),
                      PieChartSectionData(
                        value: generateData(documents, 4),
                        title: 'SNA',
                        color: const Color.fromARGB(255, 63, 237, 153),
                      ),
                      PieChartSectionData(
                        value: generateData(documents, 5),
                        title: 'ADO',
                        color: const Color.fromARGB(255, 63, 214, 237),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}

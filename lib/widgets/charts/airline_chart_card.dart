import 'dart:math' as math;

import 'package:aviation_web/data/flight.constants.dart';
import 'package:aviation_web/pages/chart_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AirlineChartCard extends StatelessWidget {
  const AirlineChartCard({Key? key, required this.documents}) : super(key: key);

  final dynamic documents;

  @override
  Widget build(BuildContext context) {
    return ChartContainer(
        title: 'Airline',
        color: const Color(0x00000000),
        chart: PieChart(
          PieChartData(
            sections: [
              ...kAirlineList
                  .map(
                    (dynamic item) => PieChartSectionData(
                      value: generateData(documents, item['value']),
                      title: item['text'],
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(1.0),
                    ),
                  )
                  .toList(),
            ],
          ),
        ));
  }

  double generateData(List<dynamic> documents, int type) {
    var count = 0.0;

    documents.forEach((dynamic document) {
      if (document.get('airline') == type) {
        count += 1.0;
      }
    });

    return count;
  }
}

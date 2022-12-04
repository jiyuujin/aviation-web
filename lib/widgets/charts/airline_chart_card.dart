import 'dart:math' as math;

import 'package:aviation_web/data/flight.constants.dart';
import 'package:aviation_web/entities/flight.entity.dart';
import 'package:aviation_web/pages/chart_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AirlineChartCard extends StatelessWidget {
  const AirlineChartCard({super.key, required this.documents});

  final List<DocumentSnapshot> documents;

  @override
  Widget build(BuildContext context) {
    List<Airline> airlines = airlineFromJson(kAirlineList);

    return Card(
        margin: const EdgeInsets.all(4),
        color: Colors.blue[100],
        shadowColor: Colors.blueGrey,
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ChartContainer(
                  title: 'Airline',
                  color: const Color(0x00000000),
                  chart: PieChart(
                    PieChartData(
                      sections: [
                        ...airlines
                            .map(
                              (Airline item) => PieChartSectionData(
                                value: generateData(documents, item.value),
                                title: item.text,
                                color: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(1.0),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  )),
            ),
          ],
        ));
  }

  double generateData(List<DocumentSnapshot> documents, int type) {
    var count = 0.0;

    documents.forEach((DocumentSnapshot document) {
      if ((document.data().toString().contains('airline')
              ? document.get('airline')
              : 0) ==
          type) {
        count += 1.0;
      }
    });

    return count;
  }
}

import 'package:aviation_web/data/flight.constants.dart';
import 'package:aviation_web/entities/flight.entity.dart';
import 'package:aviation_web/pages/chart_container.dart';
import 'package:aviation_web/services/flight.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BoardingTypeChartCard extends StatelessWidget {
  const BoardingTypeChartCard({super.key, required this.documents});

  final List<DocumentSnapshot> documents;

  @override
  Widget build(BuildContext context) {
    List<BoardingType> boardingTypes = boardingTypeFromJson(kBoardingTypeList);

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
                  title: 'Boarding Type',
                  color: const Color(0x00000000),
                  chart: BarChart(
                    BarChartData(
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(getBoardingTypeName(value.toInt()));
                          },
                        )),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        border: const Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                          left: BorderSide(width: 1),
                          bottom: BorderSide(width: 1),
                        ),
                      ),
                      groupsSpace: 10,
                      barGroups: [
                        ...boardingTypes
                            .map(
                              (BoardingType item) => BarChartGroupData(
                                x: item.value,
                                barRods: [
                                  BarChartRodData(
                                      toY: generateDataBy(
                                          documents, item.value, 2022),
                                      width: 15),
                                  BarChartRodData(
                                      toY: generateDataBy(
                                          documents, item.value, 2023),
                                      width: 15),
                                  BarChartRodData(
                                      toY: generateData(documents, item.value),
                                      width: 15),
                                ],
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
      if (document.get('boardingType') == type) {
        count += 1.0;
      }
    });

    return count;
  }

  double generateDataBy(List<DocumentSnapshot> documents, int type, int year) {
    var count = 0.0;

    documents.forEach((DocumentSnapshot document) {
      if (document.get('boardingType') == type) {
        if (document.get('time').contains(year.toString())) {
          count += 1.0;
        }
      }
    });

    return count;
  }
}

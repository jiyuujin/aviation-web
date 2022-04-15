import 'package:aviation_web/widgets/charts/airline_chart_card.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class FlightChartCards extends StatelessWidget {
  const FlightChartCards({Key? key, required this.documents}) : super(key: key);

  final List<DocumentSnapshot> documents;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(4),
        color: Colors.blue[100],
        shadowColor: Colors.blueGrey,
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: AirlineChartCard(documents: documents),
            ),
          ],
        ));
  }
}

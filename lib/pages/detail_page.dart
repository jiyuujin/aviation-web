import 'package:aviation_web/services/flight.service.dart';
import 'package:aviation_web/widgets/flight_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('flights')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text('Loading...');
            default:
              return CustomScrollView(
                slivers: <Widget>[
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            children: [
                              ...snapshot.data!.docs.map((dynamic document) {
                                var departure = getAirportName(document
                                        .data()
                                        .toString()
                                        .contains('departure')
                                    ? document.get('departure')
                                    : 0);
                                var arrival = getAirportName(document
                                        .data()
                                        .toString()
                                        .contains('arrival')
                                    ? document.get('arrival')
                                    : 0);
                                var airline = getAirlineName(document
                                        .data()
                                        .toString()
                                        .contains('airline')
                                    ? document.get('airline')
                                    : 0);
                                var boardingType = getBoardingTypeName(document
                                        .data()
                                        .toString()
                                        .contains('boardingType')
                                    ? document.get('boardingType')
                                    : 0);
                                var registration = document
                                        .data()
                                        .toString()
                                        .contains('registration')
                                    ? document.get('registration')
                                    : '';
                                return FlightCard(
                                    title: '$departure - $arrival',
                                    explain:
                                        '$airline ($boardingType, $registration)');
                              }).toList()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}

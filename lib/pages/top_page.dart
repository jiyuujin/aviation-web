import 'package:aviation_web/services/flight.service.dart';
import 'package:aviation_web/widgets/charts/airline_chart_card.dart';
import 'package:aviation_web/widgets/flight_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            label: const Text(
              'Sign out',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('flights')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                              AirlineChartCard(documents: snapshot.data!.docs),
                              ...snapshot.data!.docs.map((document) {
                                var departure =
                                    getAirportName(document.get('departure'));
                                var arrival =
                                    getAirportName(document.get('arrival'));
                                var airline =
                                    getAirlineName(document.get('airline'));
                                var boardingType = getBoardingTypeName(
                                    document.get('boardingType'));
                                var registration = document.get('registration');
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

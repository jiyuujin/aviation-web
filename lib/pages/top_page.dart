import 'package:aviation_web/services/flight.service.dart';
import 'package:aviation_web/widgets/flight_card.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

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
      body: StreamBuilder<fs.QuerySnapshot>(
        stream: firestore()
            .collection('flights')
            .orderBy('time', 'desc')
            .onSnapshot,
        builder:
            (BuildContext context, AsyncSnapshot<fs.QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text('Loading...');
            default:
              return GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                children:
                    snapshot.data!.docs.map((fs.DocumentSnapshot document) {
                  var departure = getAirportName(document.get('departure'));
                  var arrival = getAirportName(document.get('arrival'));
                  var airline = getAirlineName(document.get('airline'));
                  var boardingType =
                      getBoardingTypeName(document.get('boardingType'));
                  var registration = document.get('registration');
                  return FlightCard(
                      title: '$departure - $arrival',
                      explain: '$airline ($boardingType, $registration)');
                }).toList(),
              );
          }
        },
      ),
    );
  }
}

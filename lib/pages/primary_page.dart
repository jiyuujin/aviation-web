import 'package:aviation_web/hooks/use_firebase.dart';
import 'package:aviation_web/widgets/charts/airline_chart_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PrimaryPage extends StatelessWidget {
  PrimaryPage({super.key});

  final firebaseHook = useFirebase();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder(
        stream: firebaseHook.fetchItems(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return Column(
            children: [
              Expanded(
                child: AirlineChartCard(documents: snapshot.data!.docs),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FlightCard extends StatelessWidget {
  const FlightCard({Key? key, required this.title, required this.explain})
      : super(key: key);

  final String title;
  final String explain;

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
            ListTile(
              leading: const Icon(Icons.album, color: Colors.amber, size: 45),
              title: Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(explain),
            ),
          ],
        ));
  }
}

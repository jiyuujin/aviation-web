import 'package:aviation_web/widgets/flight_form.dart';
import 'package:flutter/material.dart';

class NewFlightPage extends StatefulWidget {
  const NewFlightPage({super.key});

  @override
  _NewFlightPageState createState() => _NewFlightPageState();
}

class _NewFlightPageState extends State<NewFlightPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: const [
          Center(
            child: NewFlight(),
          )
        ],
      ),
    );
  }
}

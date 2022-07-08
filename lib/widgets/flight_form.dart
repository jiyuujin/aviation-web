import 'package:aviation_web/data/flight.constants.dart';
import 'package:aviation_web/widgets/custom_button.dart';
import 'package:aviation_web/widgets/input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewFlight extends StatefulWidget {
  const NewFlight({super.key});

  @override
  _NewFlightState createState() => _NewFlightState();
}

class _NewFlightState extends State<NewFlight> {
  final _formKey = GlobalKey<FormState>();

  bool _isRegister = true;

  DateTime _date = DateTime.now();
  int _airline = 0;
  int _departure = 0;
  int _arrival = 0;
  int _boardingType = 0;
  String _registration = '';

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2016),
        lastDate: DateTime.now().add(const Duration(days: 360)));
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    List<String> airports = [];
    List<String> airlines = [];
    List<String> boardingTypes = [];

    kAirportList.forEach((Map<String, dynamic> a) {
      airports.add(a['text']);
    });
    kAirlineList.forEach((Map<String, dynamic> a) {
      airlines.add(a['text']);
    });
    kBoardingTypeList.forEach((Map<String, dynamic> a) {
      boardingTypes.add(a['text']);
    });

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Text(
              _isRegister ? 'Register' : 'Update',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 48),
            CustomButton(
              isLoading: _isLoading,
              text: 'Date',
              type: 'secondary',
              onPressed: () {
                _selectDate(context);
              },
            ),
            const SizedBox(height: 48),
            DropdownButton(
              items: <String>[...airports].map((String airport) {
                return DropdownMenuItem<String>(
                  value: airport,
                  child: Text(airport),
                );
              }).toList(),
              onChanged: (value) {
                List<Map<String, dynamic>> filter = (kAirportList
                    .where((Map<String, dynamic> a) => a['text'] == value)
                    .toList());
                _departure = filter[0]['value'];
              },
              isExpanded: true,
            ),
            const SizedBox(height: 48),
            DropdownButton(
              items: <String>[...airports].map((String airport) {
                return DropdownMenuItem<String>(
                  value: airport,
                  child: Text(airport),
                );
              }).toList(),
              onChanged: (value) {
                List<Map<String, dynamic>> filter = (kAirportList
                    .where((Map<String, dynamic> a) => a['text'] == value)
                    .toList());
                _arrival = filter[0]['value'];
              },
              isExpanded: true,
            ),
            const SizedBox(height: 48),
            DropdownButton(
              items: <String>[...airlines].map((String airline) {
                return DropdownMenuItem<String>(
                  value: airline,
                  child: Text(airline),
                );
              }).toList(),
              onChanged: (value) {
                List<Map<String, dynamic>> filter = (kAirlineList
                    .where((Map<String, dynamic> a) => a['text'] == value)
                    .toList());
                _airline = filter[0]['value'];
              },
              isExpanded: true,
            ),
            const SizedBox(height: 48),
            DropdownButton(
              items: <String>[...boardingTypes].map((String boardingType) {
                return DropdownMenuItem<String>(
                  value: boardingType,
                  child: Text(boardingType),
                );
              }).toList(),
              onChanged: (value) {
                List<Map<String, dynamic>> filter = (kBoardingTypeList
                    .where((Map<String, dynamic> a) => a['text'] == value)
                    .toList());
                _boardingType = filter[0]['value'];
              },
              isExpanded: true,
            ),
            const SizedBox(height: 48),
            InputField(
              label: 'Registration',
              icon: Icons.email,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'You have to enter the registration';
                }
                return null;
              },
              onSaved: (value) {
                _registration = value;
              },
              onChanged: null,
            ),
            const SizedBox(height: 48),
            CustomButton(
              isLoading: _isLoading,
              text: _isRegister ? 'Register' : 'Update',
              type: 'primary',
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        setState(() {
                          _isLoading = true;
                        });

                        if (_isRegister) {
                          try {
                            FirebaseFirestore.instance
                                .collection('flights')
                                .add({
                              'time': _date,
                              'departure': _departure,
                              'arrival': _arrival,
                              'airline': _airline,
                              'boardingType': _boardingType,
                              'registration': _registration
                            });
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              _errorMessage = 'Something has been wrong.';
                            });
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      }
                    },
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                _errorMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

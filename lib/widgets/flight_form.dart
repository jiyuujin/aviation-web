import 'package:aviation_web/data/flight.constants.dart';
import 'package:aviation_web/entities/flight.entity.dart';
import 'package:aviation_web/hooks/use_firebase.dart';
import 'package:aviation_web/widgets/custom_button.dart';
import 'package:aviation_web/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewFlight extends StatefulWidget {
  const NewFlight({super.key});

  @override
  _NewFlightState createState() => _NewFlightState();
}

class _NewFlightState extends State<NewFlight> {
  final _formKey = GlobalKey<FormState>();

  final firebaseHook = useFirebase();

  bool _isRegister = true;

  DateTime _date = DateTime.now();
  Airline? _airline;
  Airport? _departure;
  Airport? _arrival;
  BoardingType? _boardingType;
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
    List<Airport> airports = airportFromJson(kAirportList);
    List<Airline> airlines = airlineFromJson(kAirlineList);
    List<BoardingType> boardingTypes = boardingTypeFromJson(kBoardingTypeList);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            CustomButton(
              isLoading: _isLoading,
              text: 'Date',
              type: 'secondary',
              onPressed: () {
                _selectDate(context);
              },
            ),
            const SizedBox(height: 48),
            DropdownButton<Airport>(
              items: airports.map<DropdownMenuItem<Airport>>((Airport airport) {
                return DropdownMenuItem<Airport>(
                  value: airport,
                  child: Text(airport.text),
                );
              }).toList(),
              onChanged: (Airport? newValue) {
                setState(() {
                  _departure = newValue;
                });
              },
              hint: const Text('出発元の空港を選択してください'),
              // value: _departure,
              isExpanded: true,
            ),
            const SizedBox(height: 48),
            DropdownButton<Airport>(
              items: airports.map<DropdownMenuItem<Airport>>((Airport airport) {
                return DropdownMenuItem<Airport>(
                  value: airport,
                  child: Text(airport.text),
                );
              }).toList(),
              onChanged: (Airport? newValue) {
                setState(() {
                  _arrival = newValue;
                });
              },
              hint: const Text('到着先の空港を選択してください'),
              // value: _arrival,
              isExpanded: true,
            ),
            const SizedBox(height: 48),
            DropdownButton<Airline>(
              items: airlines.map<DropdownMenuItem<Airline>>((Airline airline) {
                return DropdownMenuItem<Airline>(
                  value: airline,
                  child: Text(airline.text),
                );
              }).toList(),
              onChanged: (Airline? newValue) {
                setState(() {
                  _airline = newValue;
                });
              },
              hint: const Text('航空会社を選択してください'),
              // value: _airline,
              isExpanded: true,
            ),
            const SizedBox(height: 48),
            DropdownButton<BoardingType>(
              items: boardingTypes.map<DropdownMenuItem<BoardingType>>(
                  (BoardingType boardingType) {
                return DropdownMenuItem<BoardingType>(
                  value: boardingType,
                  child: Text(boardingType.text),
                );
              }).toList(),
              onChanged: (BoardingType? newValue) {
                setState(() {
                  _boardingType = newValue;
                });
              },
              hint: const Text('搭乗機材を選択してください'),
              // value: _boardingType,
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
                            firebaseHook.insertItem({
                              'time': _date.toString(),
                              'departure': _departure!.value,
                              'arrival': _arrival!.value,
                              'airline': _airline!.value,
                              'boardingType': _boardingType!.value,
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

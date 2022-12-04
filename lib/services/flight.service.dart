import 'package:aviation_web/data/flight.constants.dart';
import 'package:aviation_web/entities/flight.entity.dart';

String getAirportName(int id) {
  // if (id == null) return '';

  List<Airport> airports = airportFromJson(kAirportList);

  var text = '';
  for (Airport airport in airports) {
    if (airport.value == id) {
      text = airport.text;
    }
  }
  return text;
}

String getAirlineName(int id) {
  // if (id == null) return '';

  List<Airline> airlines = airlineFromJson(kAirlineList);

  var text = '';
  for (Airline airline in airlines) {
    if (airline.value == id) {
      text = airline.text;
    }
  }
  return text;
}

String getBoardingTypeName(int id) {
  // if (id == null) return '';

  List<BoardingType> boardingTypes = boardingTypeFromJson(kBoardingTypeList);

  var text = '';
  for (BoardingType boardingType in boardingTypes) {
    if (boardingType.value == id) {
      text = boardingType.text;
    }
  }
  return text;
}

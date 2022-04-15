import 'package:aviation_web/data/flight.constants.dart';

String getAirportName(dynamic id) {
  if (id == null) return '';

  var text = '';
  for (Map<String, dynamic> airport in kAirportList) {
    if (airport['value'] == id) {
      text = airport['text'];
    }
  }
  return text;
}

String getAirlineName(dynamic id) {
  if (id == null) return '';

  var text = '';
  for (Map<String, dynamic> airline in kAirlineList) {
    if (airline['value'] == id) {
      text = airline['text'];
    }
  }
  return text;
}

String getBoardingTypeName(dynamic id) {
  if (id == null) return '';

  var text = '';
  for (Map<String, dynamic> boardingType in kBoardingTypeList) {
    if (boardingType['value'] == id) {
      text = boardingType['text'];
    }
  }
  return text;
}

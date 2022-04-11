import 'package:aviation_web/data/flight.constants.dart';

String getAirportName(dynamic id) {
  if (id == null) return '';

  var text = '';
  for (var airport in kAirportList) {
    if (airport['value'] == id) {
      text = airport['text'];
    }
  }
  return text;
}

String getAirlineName(dynamic id) {
  if (id == null) return '';

  var text = '';
  for (var airline in kAirlineList) {
    if (airline['value'] == id) {
      text = airline['text'];
    }
  }
  return text;
}

String getBoardingTypeName(dynamic id) {
  if (id == null) return '';

  var text = '';
  for (var boardingType in kBoardingTypeList) {
    if (boardingType['value'] == id) {
      text = boardingType['text'];
    }
  }
  return text;
}

double generateData(List<dynamic> documents, int type) {
  var jal = 0.0;
  var ana = 0.0;
  var sky = 0.0;
  var sfj = 0.0;
  var sna = 0.0;
  var ado = 0.0;

  documents.forEach((dynamic document) {
    if (document.get('airline') == 0) {
      jal += 1.0;
    } else if (document.get('airline') == 1) {
      ana += 1.0;
    } else if (document.get('airline') == 2) {
      sky += 1.0;
    } else if (document.get('airline') == 3) {
      sfj += 1.0;
    } else if (document.get('airline') == 4) {
      sna += 1.0;
    } else if (document.get('airline') == 5) {
      ado += 1.0;
    } else {
      //
    }
  });

  if (type == 0) {
    return jal;
  } else if (type == 1) {
    return ana;
  } else if (type == 2) {
    return sky;
  } else if (type == 3) {
    return sfj;
  } else if (type == 4) {
    return sna;
  } else if (type == 5) {
    return ado;
  }
  return 0.0;
}

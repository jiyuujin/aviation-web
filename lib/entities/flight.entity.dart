import 'dart:convert';

List<Airport> airportFromJson(String str) =>
    List<Airport>.from(json.decode(str).map((x) => Airport.fromJson(x)));

List<Airline> airlineFromJson(String str) =>
    List<Airline>.from(json.decode(str).map((x) => Airline.fromJson(x)));

List<BoardingType> boardingTypeFromJson(String str) => List<BoardingType>.from(
    json.decode(str).map((x) => BoardingType.fromJson(x)));

String airportToJson(List<Airport> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String airlineToJson(List<Airline> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String boardingTypeToJson(List<BoardingType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Airport {
  Airport({required this.value, required this.text});

  int value;
  String text;

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
        value: json['value'],
        text: json['text'],
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'text': text,
      };
}

class Airline {
  Airline({required this.value, required this.text, required this.image});

  int value;
  String text;
  String image;

  factory Airline.fromJson(Map<String, dynamic> json) =>
      Airline(value: json['value'], text: json['text'], image: json['image']);

  Map<String, dynamic> toJson() => {
        'value': value,
        'text': text,
        'image': image,
      };
}

class BoardingType {
  BoardingType({required this.value, required this.text});

  int value;
  String text;

  factory BoardingType.fromJson(Map<String, dynamic> json) => BoardingType(
        value: json['value'],
        text: json['text'],
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'text': text,
      };
}

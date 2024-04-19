// ignore_for_file: non_constant_identifier_names, duplicate_ignore

class Weather {
  // ignore: non_constant_identifier_names
  final String City;
  final double temperature;
  // ignore: non_constant_identifier_names
  final String Condition;

  Weather(
      // ignore: non_constant_identifier_names
      {required this.City,
      required this.temperature,
      required this.Condition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      City: json['name'],
      temperature: json['main']['temp'].toDouble(),
      Condition: json['weather'][0]['main'],
    );
  }
}

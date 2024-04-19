// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather2_0/const.dart';
import 'package:weather2_0/models/weather_model.dart';
import 'package:weather2_0/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => pageState();
}

// ignore: camel_case_types
class pageState extends State<WeatherPage> {
  //Need api key

  final _weatherService = WeatherService(apiKEY);
  Weather? _weather;

  //get weather data

  fetchWeather() async {
    //getting city name
    String cityname = await _weatherService.getCurrentCity();

    //get data for city

    try {
      final weather = await _weatherService.getWeather(cityname);
      setState(() {
        _weather = weather;
      });
    }

    //errors-
    catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //animations
  String getWeatherAnimation(String? Condition) {
    if (Condition == null) return 'asset/error.json'; //default animation

    switch (Condition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
        return 'assets/daystorm.json';
      case 'shower rain':
      case 'drizzle':
        return 'assets/shower.json';
      case 'thunderstorm':
        return 'assets/rain.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/error.json';
    }
  }

  //initial state:

  @override
  void initState() {
    super.initState();

    //run fetch weather on startup
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //display city name
              Text(
                _weather?.City ?? "loading city...",
                style: const TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 35,
                ),
              ),

              //adding animations
              Lottie.asset(getWeatherAnimation(_weather?.Condition)),

              //display city temp
              Text(
                '${_weather?.temperature.round()}°C',
                style: const TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 35,
                ),
              ),

              //checking weather condition for animations:
              Text(
                _weather?.Condition ?? "",
                style: const TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ));
  }
}

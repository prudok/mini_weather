import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/api_constants.dart';

import '../../domain/entities/current_weather/current_weather.dart';
import 'weather_api.dart';

class WeatherAPIImpl extends WeatherAPI {
  WeatherAPIImpl(this.cityName);
  String cityName;

  @override
  Future<CurrentWeather> loadCurrentWeatherByName(String cityName) async {
    var queryParameters = {
      'key': APIConstants.apiKey,
      //TODO: Change to cityName
      'q': cityName,
    };
    var uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.currentWeatherPath,
      queryParameters,
    );
    var response = http.get(uri);
    //TODO: remove the statements
    return response.then((weather) {
      return CurrentWeather.fromJson(jsonDecode(weather.body));
    });
  }
}

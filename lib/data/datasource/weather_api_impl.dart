import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/api_constants.dart';
import 'package:weather_app/domain/entities/weather_forecast/weather_forecast.dart';

import '../../domain/entities/current_weather/current_weather.dart';
import '../../domain/entities/weather_forecast/weather_forecast_weekly.dart';
import 'weather_api.dart';

class WeatherAPIImpl extends WeatherAPI {
  WeatherAPIImpl({this.cityName});
  String? cityName;

  @override
  Future<Weather> loadCurrentWeatherByName(String cityName) async {
    var queryParameters = {
      'key': APIConstants.apiKey,
      'q': cityName,
    };
    var uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.currentWeatherPath,
      queryParameters,
    );
    var response = http.get(uri);
    return response.then((weather) {
      return Weather.fromJson(jsonDecode(weather.body));
    });
  }

  @override
  Future<WeatherForecastWeekly> loadWeatherForecastByName(String cityName) {
    var queryParameters = {
      'key': APIConstants.apiKey,
      'q': cityName,
    };
    var uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.weatherForecastPath,
      queryParameters,
    );
    var response = http.get(uri);
    return response.then((weather) {
      return WeatherForecastWeekly.fromJson(jsonDecode(weather.body));
    });
  }
}

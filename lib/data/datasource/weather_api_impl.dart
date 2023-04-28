import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/api_constants.dart';

import '../../domain/entities/weather_forecast/weather_forecast_weekly.dart';
import 'weather_api.dart';

class WeatherAPIImpl extends WeatherAPI {
  WeatherAPIImpl({this.cityName});
  String? cityName;

  @override
  Future<WeatherForecastWeekly> loadWeatherForecastByName(String cityName) {
    var queryParameters = {
      'key': APIConstants.apiKey,
      'q': cityName,
      'days': '14',
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

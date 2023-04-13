import '../../domain/entities/current_weather/current_weather.dart';

abstract class WeatherAPI {
  Future<CurrentWeather> loadCurrentWeatherByName(String cityName);
}
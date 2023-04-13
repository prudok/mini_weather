import '../entities/current_weather/current_weather.dart';

abstract class WeatherRepository {
  Future<CurrentWeather> getWeather(String cityName);
}
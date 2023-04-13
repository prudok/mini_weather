import '../../entities/current_weather/current_weather.dart';

abstract class GetCurrentWeather {
  Future<CurrentWeather> call(String cityName);
}
import '../../entities/current_weather/current_weather.dart';

abstract class GetCurrentWeatherUseCase {
  Future<Weather> call(String cityName);
}
import '../../domain/entities/current_weather/current_weather.dart';
import '../../domain/entities/weather_forecast/weather_forecast_weekly.dart';

abstract class WeatherAPI {
  Future<Weather> loadCurrentWeatherByName(String cityName);
  Future<WeatherForecastWeekly> loadWeatherForecastByName(String cityName);
}
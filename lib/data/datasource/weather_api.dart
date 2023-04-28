import '../../domain/entities/weather_forecast/weather_forecast_weekly.dart';

abstract class WeatherAPI {
  Future<WeatherForecastWeekly> loadWeatherForecastByName(String cityName);
}
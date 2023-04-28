import '../entities/weather_forecast/weather_forecast_weekly.dart';

abstract class WeatherRepository {
  Future<WeatherForecastWeekly> getWeatherForecast(String cityName);
}
import 'package:weather_app/domain/entities/weather_forecast/weather_forecast.dart';

import '../entities/current_weather/current_weather.dart';
import '../entities/weather_forecast/weather_forecast_weekly.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String cityName);
  Future<WeatherForecastWeekly> getWeatherForecast(String cityName);
}
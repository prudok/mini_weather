import '../../entities/weather_forecast/weather_forecast.dart';
import '../../entities/weather_forecast/weather_forecast_weekly.dart';

abstract class GetWeatherForecastUseCase {
  Future<WeatherForecastWeekly> call(String cityName);
}
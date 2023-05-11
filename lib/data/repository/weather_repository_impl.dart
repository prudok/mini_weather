import '../../domain/entities/weather_forecast/weather_forecast_weekly.dart';
import '../../domain/repository/weather_repository.dart';
import '../datasource/weather_api.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherAPI weatherAPI;

  WeatherRepositoryImpl(this.weatherAPI);

  @override
  Future<WeatherForecastWeekly> getWeatherForecast(String cityName) async {
    return await weatherAPI.loadWeatherForecastByName(cityName);
  }
}

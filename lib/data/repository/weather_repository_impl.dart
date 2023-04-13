import '../../domain/entities/current_weather/current_weather.dart';
import '../../domain/repository/weather_repository.dart';
import '../datasource/weather_api.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherAPI weatherAPI;

  WeatherRepositoryImpl(this.weatherAPI);
  @override
  Future<CurrentWeather> getWeather(String cityName) async {
    return await weatherAPI.loadCurrentWeatherByName(cityName);
  }
}

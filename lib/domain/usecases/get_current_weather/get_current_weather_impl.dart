import '../../entities/current_weather/current_weather.dart';
import '../../repository/weather_repository.dart';
import 'get_current_weather.dart';

class GetCurrentWeatherImpl extends GetCurrentWeather {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherImpl(this.weatherRepository);

  @override
  Future<CurrentWeather> call(String cityName) async {
    return await weatherRepository.getWeather(cityName);
  }
}

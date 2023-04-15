import '../../entities/current_weather/current_weather.dart';
import '../../repository/weather_repository.dart';
import 'get_current_weather.dart';

class GetCurrentWeatherUseCaseImpl extends GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCaseImpl(this.weatherRepository);

  @override
  Future<CurrentWeather> call(String cityName) async {
    return await weatherRepository.getWeather(cityName);
  }
}

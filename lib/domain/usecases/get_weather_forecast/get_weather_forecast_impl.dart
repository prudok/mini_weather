import 'package:weather_app/domain/repository/weather_repository.dart';
import 'package:weather_app/domain/usecases/get_weather_forecast/get_weather_forecast.dart';

import '../../entities/weather_forecast/weather_forecast_weekly.dart';

class GetWeatherForecastUseCaseImpl extends GetWeatherForecastUseCase {
  final WeatherRepository weatherRepository;

  GetWeatherForecastUseCaseImpl(this.weatherRepository);
  @override
  Future<WeatherForecastWeekly> call(String cityName) async {
    return await weatherRepository.getWeatherForecast(cityName);
  }
}

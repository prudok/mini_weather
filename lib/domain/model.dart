import '../data/model.dart';
import 'usecases/get_weather_forecast/get_weather_forecast_impl.dart';

final getWeatherForecastProvider = GetWeatherForecastUseCaseImpl(weatherRepositoryProvider);
import 'package:weather_app/domain/usecases/get_weather_forecast/get_weather_forecast_impl.dart';

import '../data/model.dart';
import 'usecases/get_current_weather/get_current_weather_impl.dart';

final getCurrentWeatherProvider = GetCurrentWeatherUseCaseImpl(weatherRepositoryProvider);

final getWeatherForecastProvider = GetWeatherForecastUseCaseImpl(weatherRepositoryProvider);
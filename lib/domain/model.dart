import '../data/model.dart';
import 'usecases/get_current_weather/get_current_weather_impl.dart';

final getCurrentWeatherProvider = GetCurrentWeatherUseCaseImpl(weatherRepositoryProvider);
import 'datasource/weather_api_impl.dart';
import 'repository/weather_repository_impl.dart';

final weatherAPIProvider = WeatherAPIImpl();

final weatherRepositoryProvider = WeatherRepositoryImpl(weatherAPIProvider);
  
part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState {
  WeatherForecastWeekly? weatherForecastWeekly;
  Weather? weather;
}

class CurrentWeatherInitialState extends CurrentWeatherState {
  @override
  Weather? get weather => null;
}

class WeatherLoadingState extends CurrentWeatherState {
  @override
  Weather? get weather => null;
}

class CurrentWeatherLoadedState extends CurrentWeatherState {
  @override
  final Weather weather;

  CurrentWeatherLoadedState(this.weather);
}

class CurrentWeatherForecastState extends CurrentWeatherState {
  @override
  final WeatherForecastWeekly weatherForecastWeekly;

  CurrentWeatherForecastState(this.weatherForecastWeekly);

}

class CurrentWeatherErrorState extends CurrentWeatherState {
  CurrentWeatherErrorState(this.message);
  final String message;

  @override
  Weather? get weather => throw UnimplementedError();
}

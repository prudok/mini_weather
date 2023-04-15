part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState {
  CurrentWeather? currentWeather;
}

class CurrentWeatherLoading extends CurrentWeatherState {
  @override
  CurrentWeather? get currentWeather => null;
}

class CurrentWeatherLoaded extends CurrentWeatherState {
  @override
  final CurrentWeather currentWeather;

  CurrentWeatherLoaded(this.currentWeather);
}

class CurrentWeatherError extends CurrentWeatherState {
  CurrentWeatherError(this.message);
  final String message;

  @override
  CurrentWeather? get currentWeather => throw UnimplementedError();
}

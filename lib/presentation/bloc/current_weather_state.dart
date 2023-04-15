part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState {
  CurrentWeather? currentWeather;
}

class CurrentWeatherLoadingState extends CurrentWeatherState {
  @override
  CurrentWeather? get currentWeather => null;
}

class CurrentWeatherLoadedState extends CurrentWeatherState {
  @override
  final CurrentWeather currentWeather;

  CurrentWeatherLoadedState(this.currentWeather);
}

class CurrentWeatherErrorState extends CurrentWeatherState {
  CurrentWeatherErrorState(this.message);
  final String message;

  @override
  CurrentWeather? get currentWeather => throw UnimplementedError();
}

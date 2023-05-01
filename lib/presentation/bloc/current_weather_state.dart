part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState {
  WeatherForecastWeekly? weatherForecastWeekly;
}

class CurrentWeatherInitialState extends CurrentWeatherState {}

class CurrentWeatherForecastState extends CurrentWeatherState {
  @override
  final WeatherForecastWeekly weatherForecastWeekly;

  CurrentWeatherForecastState(this.weatherForecastWeekly);
}

class CurrentWeatherForecastLoading extends CurrentWeatherState {}

class CurrentWeatherErrorState extends CurrentWeatherState {
  CurrentWeatherErrorState(this.message);
  final String message;

  @override
  WeatherForecastWeekly? get weatherForecastWeekly =>
      throw UnimplementedError();
}

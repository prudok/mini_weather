part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent {
  const CurrentWeatherEvent();
}

class CurrentWeatherLoadEvent extends CurrentWeatherEvent {
  const CurrentWeatherLoadEvent(this.cityName);
  final String cityName;
}

class CurrentWeatherForecastEvent extends CurrentWeatherEvent {
  const CurrentWeatherForecastEvent(this.cityName);
  final String cityName;
}

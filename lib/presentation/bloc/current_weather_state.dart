part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState {
  WeatherForecastWeekly? weatherForecastWeekly;
}

class CurrentWeatherInitialState extends CurrentWeatherState {
}

class WeatherLoadingState extends CurrentWeatherState {
}

class CurrentWeatherLoadedState extends CurrentWeatherState {
}

class CurrentWeatherForecastState extends CurrentWeatherState {
  @override
  final WeatherForecastWeekly weatherForecastWeekly;

  CurrentWeatherForecastState(this.weatherForecastWeekly);

}

class CurrentWeatherErrorState extends CurrentWeatherState {
  CurrentWeatherErrorState(this.message);
  final String message;

  // @override
  // Weather? get weather => throw UnimplementedError();
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/current_weather/current_weather.dart';
import '../../domain/entities/weather_forecast/weather_forecast_weekly.dart';
import '../../domain/model.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc() : super(CurrentWeatherInitialState()) {

    on<CurrentWeatherLoadEvent>((event, emit) async {
      emit(WeatherLoadingState());
      await getCurrentWeatherProvider.call(event.cityName).then((currentWeather) => emit(
            CurrentWeatherLoadedState(currentWeather),
          ));
    });

    on<CurrentWeatherForecastEvent>((event, emit) async {
      emit(WeatherLoadingState());
      await getWeatherForecastProvider.call(event.cityName).then((currentWeatherForecastWeekly) => emit(
            CurrentWeatherForecastState(currentWeatherForecastWeekly),
          ));
    });
  }
}

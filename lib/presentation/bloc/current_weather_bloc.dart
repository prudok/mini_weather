import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/datasource/weather_api.dart';
import '../../data/datasource/weather_api_impl.dart';
import '../../data/repository/weather_repository_impl.dart';
import '../../domain/entities/current_weather/current_weather.dart';
import '../../domain/usecases/get_current_weather/get_current_weather.dart';
import '../../domain/usecases/get_current_weather/get_current_weather_impl.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc() : super(CurrentWeatherLoading()) {
    WeatherAPI weatherAPI = WeatherAPIImpl('London');
    CurrentWeather currentWeather = CurrentWeather();
    GetCurrentWeatherUseCase getCurrentWeather = GetCurrentWeatherUseCaseImpl(
      WeatherRepositoryImpl(weatherAPI),
    );

    on<CurrentWeatherLoadEvent>((event, emit) {
      emit(CurrentWeatherLoading());
      getCurrentWeather.call(event.cityName).then(
            (weather) => currentWeather = weather,
          );
      weatherAPI = WeatherAPIImpl(event.cityName);
      emit(CurrentWeatherLoaded(currentWeather));
    });
  }
}

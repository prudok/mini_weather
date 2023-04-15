import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model.dart';
import 'package:weather_app/domain/model.dart';

import '../../domain/entities/current_weather/current_weather.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc() : super(CurrentWeatherLoadingState()) {
    CurrentWeather currentWeather;
    on<CurrentWeatherLoadEvent>((event, emit) async {
      await getCurrentWeatherProvider.call(event.cityName).then((value) => emit(
            CurrentWeatherLoadedState(value),
          ));
      weatherAPIProvider.cityName = event.cityName;
    });
  }
}

import 'package:flutter/material.dart';

import '../data/datasource/weather_api_impl.dart';
import '../data/repository/weather_repository_impl.dart';
import '../domain/usecases/get_current_weather/get_current_weather.dart';
import '../domain/usecases/get_current_weather/get_current_weather_impl.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                GetCurrentWeather getCurrentWeather = GetCurrentWeatherImpl(
                  WeatherRepositoryImpl(
                    WeatherAPIImpl(),
                  ),
                );
                getCurrentWeather.call('London');
              },
              child: const Text('Current Weather'),
            ),
          ],
        ),
      ),
    );
  }
}

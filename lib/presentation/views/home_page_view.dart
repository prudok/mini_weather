
import 'package:flutter/material.dart';

import '../../data/datasource/weather_api_impl.dart';
import '../../data/repository/weather_repository_impl.dart';
import '../../domain/entities/current_weather/current_weather.dart';
import '../../domain/usecases/get_current_weather/get_current_weather.dart';
import '../../domain/usecases/get_current_weather/get_current_weather_impl.dart';

//TODO: convert into the stateless widget
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurrentWeather? outputWeather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Do You Want To Know Current Weather?'),
            ElevatedButton(
              onPressed: () {
                GetCurrentWeather getCurrentWeather = GetCurrentWeatherImpl(
                  WeatherRepositoryImpl(
                    WeatherAPIImpl(),
                  ),
                );
                getCurrentWeather.call('London').then(
                  (value) {
                    setState(() {
                      outputWeather = value;
                    });
                  },
                );
              },
              child: const Text('Get Weather'),
            ),
            Text(
              outputWeather == null
                  ? ''
                  : '${outputWeather!.current!.feelslikeC}C',
            ),
          ],
        ),
      ),
    );
  }
}

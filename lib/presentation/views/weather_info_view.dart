import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/entities/weather_forecast/weather_forecast_weekly.dart';

import '../bloc/current_weather_bloc.dart';

class WeatherInfoView extends StatelessWidget {
  const WeatherInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        var currentWeatherBloc = context.watch<CurrentWeatherBloc>();
        var weatherForecastWeekly = currentWeatherBloc.state.weatherForecastWeekly;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Weather Info'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: 14,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          '${weatherForecastWeekly?.forecast!.forecastday?[index].date}'),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

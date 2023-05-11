import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/current_weather_bloc.dart';

class WeatherInfoExpanded extends StatelessWidget {
  const WeatherInfoExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        final currentWeatherBloc = context.watch<CurrentWeatherBloc>();
        final weatherForecastWeekly =
            currentWeatherBloc.state.weatherForecastWeekly;
        final weatherForecast = weatherForecastWeekly?.forecast?.forecastday;

        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
            itemCount: weatherForecast?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  trailing: weatherForecast?[index].day?.condition?.icon == null
                      ? null
                      : Image.network(
                          'http:${weatherForecast?[index].day?.condition?.icon}',
                        ),
                  title: Text(
                    '${weatherForecast?[index].date},  ${weatherForecast?[index].day?.condition?.text} - ${weatherForecast?[index].day?.mintempC} °C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

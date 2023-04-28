import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/current_weather_bloc.dart';

class WeatherInfoView extends StatelessWidget {
  const WeatherInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        final currentWeatherBloc = context.watch<CurrentWeatherBloc>();
        final weatherForecastWeekly =
            currentWeatherBloc.state.weatherForecastWeekly;
        final weatherForecastList =
            weatherForecastWeekly?.forecast?.forecastday;
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
                  itemCount: weatherForecastList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        trailing:
                            weatherForecastList?[index].day?.condition?.icon ==
                                    null
                                ? null
                                : Image.network(
                                    'http:${weatherForecastList?[index].day?.condition?.icon}',
                                  ),
                        title: Text(
                          '${weatherForecastList?[index].date},  ${weatherForecastList?[index].day?.condition?.text} - ${weatherForecastList?[index].day?.mintempC} °C',
                        ),
                      ),
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

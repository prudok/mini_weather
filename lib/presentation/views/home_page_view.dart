import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/entities/weather_forecast/weather_forecast_weekly.dart';

import '../../domain/entities/current_weather/current_weather.dart';
import '../../domain/entities/weather_forecast/weather_forecast.dart';
import '../bloc/current_weather_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityNameController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        CurrentWeatherBloc currentWeatherBloc =
            context.watch<CurrentWeatherBloc>();
        Weather? weather = currentWeatherBloc.state.weather;
        WeatherForecastWeekly? weatherForecast =
            currentWeatherBloc.state.weatherForecastWeekly;
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
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    key: _formKey,
                    controller: _cityNameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_city),
                      hintText: 'Enter City Name',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    _cityNameController.text == ''
                        ? null
                        : currentWeatherBloc.add(
                            CurrentWeatherLoadEvent(
                              _cityNameController.text,
                            ),
                          );
                  },
                  child: const Text('Get Weather'),
                ),
                const SizedBox(height: 15),
                weather?.location?.name == null
                    ? Center(
                        child: currentWeatherBloc.state is WeatherLoadingState
                            ? const CircularProgressIndicator()
                            : const Text('No City Found'),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(weather!.location!.region!),
                          Text('Temperature: ${weather.current!.tempC} °C'),
                          Text('Wind Kph: ${weather.current!.windKph}'),
                        ],
                      ),
                ElevatedButton(
                  onPressed: () {
                    _cityNameController.text == ''
                        ? null
                        : currentWeatherBloc.add(
                            CurrentWeatherForecastEvent(
                              _cityNameController.text,
                            ),
                          );
                  },
                  child: const Text('Get Weather Forecast'),
                ),
                currentWeatherBloc.state is WeatherLoadingState
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, ind) {
                            return ListTile(
                              title: Text(weatherForecast == null
                                  ? 'No City Found'
                                  : '${weatherForecast.forecast?.forecastday?[ind].day?.maxtempC}'),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

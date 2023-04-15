import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/current_weather/current_weather.dart';
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
        CurrentWeather weather = currentWeatherBloc.state.currentWeather!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Weather App'),
            centerTitle: true,
          ),
          body: CurrentWeatherState is CurrentWeatherLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do You Want To Know Current Weather?'),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
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
                      weather.location!.name == null
                          ? const Center(
                              child: Text('City Not Found'),
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(weather.location!.region!),
                                Text('Temperature: ${weather.current!.tempC} °C'),
                                Text('Wind Kph: ${weather.current!.windKph}'),
                              ],
                            ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

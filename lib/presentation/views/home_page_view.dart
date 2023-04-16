import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/views/weather_info_view.dart';

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
        return Scaffold(
          appBar: AppBar(
            title: const Text('Weather App'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter City Name'),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_cityNameController.text == '') {
                      return;
                    } else {
                      currentWeatherBloc.add(
                        CurrentWeatherForecastEvent(_cityNameController.text),
                      );
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return const WeatherInfoView();
                      }));
                    }
                  },
                  child: const Text('Get Weather'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

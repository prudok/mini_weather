import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../bloc/current_weather_bloc.dart';
import 'weather_info_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityNameController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final DateTime currentTime = DateTime.now();
  Artboard? _riverArtboard;
  StateMachineController? _stateMachineController;
  SMIInput<bool>? _isCloudy;
  SMIInput<double>? _timeInHours;
  SMIInput<bool>? _isRainy;
  SMIInput<bool>? _isOpen;

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/animation/weather_app.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artboard, 'weather');
        if (controller != null) {
          artboard.addController(controller);
          _isCloudy = controller.findInput('cloudy');
          _isRainy = controller.findInput('rainy');
          _isOpen = controller.findInput('isOpen');
          _timeInHours = controller.findInput('time');
          setState(() {
            _riverArtboard = artboard;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        CurrentWeatherBloc currentWeatherBloc =
            context.watch<CurrentWeatherBloc>();
        final weatherForecastWeekly =
            currentWeatherBloc.state.weatherForecastWeekly;
        final weatherForecastList =
            weatherForecastWeekly?.forecast?.forecastday;
        _timeInHours?.value = currentTime.hour.toDouble();

        if (weatherForecastList?[0].day?.condition?.code == 1063 ||
            weatherForecastList?[0].day?.condition?.code == 1003 ||
            weatherForecastList?[0].day?.condition?.code == 1063) {
          _isCloudy?.value = true;
          _isRainy?.value = false;
          _isOpen?.value = true;
        }

        if (weatherForecastList?[0].day?.condition?.code == 1000) {
          _isCloudy?.value = false;
          _isOpen?.value = true;
          _isRainy?.value = false;
        }

        if (weatherForecastList?[0].day?.condition?.code == 1189 ||
            weatherForecastList?[0].day?.condition?.code == 1180 ||
            weatherForecastList?[0].day?.condition?.code == 1189 ||
            weatherForecastList?[0].day?.condition?.code == 1192 ||
            weatherForecastList?[0].day?.condition?.code == 1195 ||
            weatherForecastList?[0].day?.condition?.code == 1183) {
          _isCloudy?.value = true;
          _isRainy?.value = true;
          _isOpen?.value = true;
        }

        return Scaffold(
          body: _riverArtboard == null
              ? const SizedBox()
              : SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Rive(
                          fit: BoxFit.cover,
                          artboard: _riverArtboard!,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
                            children: [
                              currentWeatherBloc.state
                                      is CurrentWeatherForecastLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : weatherForecastList == null &&
                                          currentWeatherBloc.state
                                              is CurrentWeatherForecastState
                                      ? const Center(
                                          child: Text('No Data Found'),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: const WeatherInfoView(),
                                        ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 30,
                                ),
                                child: TextFormField(
                                  key: _formKey,
                                  controller: _cityNameController,
                                  onFieldSubmitted: (term) {
                                    currentWeatherBloc.add(
                                      CurrentWeatherForecastEvent(
                                        _cityNameController.text,
                                      ),
                                    );
                                  },
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter City Name',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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

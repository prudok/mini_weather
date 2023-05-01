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

        if (weatherForecastList?[0].day?.condition?.code == 1000) {
          _isCloudy?.value == true;
          _isRainy?.value == true;
        }

        if (weatherForecastList?[0].day?.condition?.code == 1003 ||
            weatherForecastList?[0].day?.condition?.code == 1006) {
          _isCloudy!.value == true;
          _isRainy!.value == false;
        }

        if (weatherForecastList?[0].day?.condition?.code == 1063 ||
            weatherForecastList?[0].day?.condition?.code == 1066) {
          _isCloudy!.value == true;
          _isRainy!.value == false;
        }
        return Scaffold(
          body: _riverArtboard == null
              ? const SizedBox()
              : Stack(
                  children: [
                    Rive(
                      fit: BoxFit.cover,
                      artboard: _riverArtboard!,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 40,
                        ),
                        child: CityNameForm(
                          formKey: _formKey,
                          cityNameController: _cityNameController,
                          currentWeatherBloc: currentWeatherBloc,
                        ),
                      ),
                    ),
                    currentWeatherBloc.state is CurrentWeatherForecastLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : weatherForecastList?.isEmpty == null &&
                                currentWeatherBloc.state
                                    is CurrentWeatherForecastLoading
                            ? const Center(
                                child: Text('No Data'),
                              )
                            : Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 150,
                                  ),
                                  child: Card(
                                    child: Text(
                                        '${weatherForecastList?[0].date},  ${weatherForecastList?[0].day?.condition?.text} - ${weatherForecastList?[0].day?.mintempC} °C'),
                                  ),
                                ),
                              ),
                  ],
                ),
        );
      },
    );
  }
}

class CityNameForm extends StatelessWidget {
  const CityNameForm({
    super.key,
    required GlobalKey<State<StatefulWidget>> formKey,
    required TextEditingController cityNameController,
    required this.currentWeatherBloc,
  })  : _formKey = formKey,
        _cityNameController = cityNameController;

  final GlobalKey<State<StatefulWidget>> _formKey;
  final TextEditingController _cityNameController;
  final CurrentWeatherBloc currentWeatherBloc;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formKey,
      controller: _cityNameController,
      onFieldSubmitted: (term) {
        currentWeatherBloc.add(
          CurrentWeatherForecastEvent(_cityNameController.text),
        );
      },
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      decoration: const InputDecoration(
        hintText: 'Enter City Name',
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}

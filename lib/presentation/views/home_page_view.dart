import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../config/status_codes/status_codes.dart';
import '../../core/constants/text_styles.dart';
import '../../domain/entities/weather_forecast/forecast_day/forecast_day.dart';
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
        final currentDayStatusCode =
            weatherForecastList?[0].day?.condition?.code;

        _timeInHours?.value = currentTime.hour.toDouble();

        final phoneHeight = MediaQuery.of(context).size.height;
        final phoneWidth = MediaQuery.of(context).size.width;

        if (StatusCodes.isCloudy(currentDayStatusCode)) {
          _isCloudy?.value = true;
          _isRainy?.value = false;
          _isOpen?.value = true;
        }

        if (StatusCodes.isSunny(currentDayStatusCode)) {
          _isCloudy?.value = false;
          _isOpen?.value = true;
          _isRainy?.value = false;
        }

        if (StatusCodes.isRainy(currentDayStatusCode)) {
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
                        width: phoneWidth,
                        height: phoneHeight,
                        child: Rive(
                          fit: BoxFit.cover,
                          artboard: _riverArtboard!,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: WeatherDataInfo(
                          phoneWidth: phoneWidth,
                          phoneHeight: phoneHeight,
                          currentWeatherBloc: currentWeatherBloc,
                          weatherForecastList: weatherForecastList,
                          formKey: _formKey,
                          cityNameController: _cityNameController,
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

class WeatherDataInfo extends StatelessWidget {
  const WeatherDataInfo({
    super.key,
    required this.phoneWidth,
    required this.phoneHeight,
    required this.currentWeatherBloc,
    required this.weatherForecastList,
    required GlobalKey<State<StatefulWidget>> formKey,
    required TextEditingController cityNameController,
  })  : _formKey = formKey,
        _cityNameController = cityNameController;

  final double phoneWidth;
  final double phoneHeight;
  final CurrentWeatherBloc currentWeatherBloc;
  final List<Forecastday>? weatherForecastList;
  final GlobalKey<State<StatefulWidget>> _formKey;
  final TextEditingController _cityNameController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: phoneWidth,
      height: phoneHeight * 0.5,
      child: Column(
        children: [
          currentWeatherBloc.state is CurrentWeatherForecastLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : weatherForecastList == null &&
                      currentWeatherBloc.state is CurrentWeatherForecastState
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 100),
                      child: const Text(
                        'No Data Found',
                        style: AppTextStyles.titleSmall,
                      ),
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
              style: AppTextStyles.titleLarge,
              decoration: const InputDecoration(
                hintText: 'Enter City Name',
                hintStyle: AppTextStyles.titleLarge,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

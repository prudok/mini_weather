import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:weather_app/core/constants/assets_paths.dart';
import 'package:weather_app/core/constants/frame_sizes.dart';

import '../../config/status_codes/status_codes.dart';
import '../bloc/current_weather_bloc.dart';
import '../widgets/weather_data_info.dart';

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

  void _setCloudAnimation() {
    _isCloudy?.value = true;
    _isRainy?.value = false;
    _isOpen?.value = true;
  }

  void _setSunnyAnimation() {
    _isCloudy?.value = false;
    _isOpen?.value = true;
    _isRainy?.value = false;
  }

  void _setRainyAnimation() {
    _isCloudy?.value = true;
    _isRainy?.value = true;
    _isOpen?.value = true;
  }

  @override
  void initState() {
    super.initState();

    rootBundle.load(AssetsPaths.weatherBackgroundAnimation).then(
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
        FrameSize.init(context: context);
        CurrentWeatherBloc currentWeatherBloc =
            context.watch<CurrentWeatherBloc>();
        final weatherForecastWeekly =
            currentWeatherBloc.state.weatherForecastWeekly;
        final weatherForecastList =
            weatherForecastWeekly?.forecast?.forecastday;
        final currentDayStatusCode =
            weatherForecastList?[0].day?.condition?.code;

        _timeInHours?.value = currentTime.hour.toDouble();

        if (StatusCodes.isCloudy(currentDayStatusCode)) {
          _setCloudAnimation();
        }

        if (StatusCodes.isSunny(currentDayStatusCode)) {
          _setSunnyAnimation();
        }

        if (StatusCodes.isRainy(currentDayStatusCode)) {
          _setRainyAnimation();
        }

        return Scaffold(
          body: _riverArtboard == null
              ? const SizedBox()
              : SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: FrameSize.screenWidth,
                        height: FrameSize.screenHeight,
                        child: Rive(
                          fit: BoxFit.cover,
                          artboard: _riverArtboard!,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: WeatherDataInfo(
                          phoneWidth: FrameSize.screenWidth,
                          phoneHeight: FrameSize.screenHeight,
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

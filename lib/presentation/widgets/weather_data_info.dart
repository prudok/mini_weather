import 'package:flutter/material.dart';

import '../../core/constants/text_styles.dart';
import '../../domain/entities/weather_forecast/forecast_day/forecast_day.dart';
import '../bloc/current_weather_bloc.dart';
import 'weather_info_expanded.dart';

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
                      child: const WeatherInfoExpanded(),
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
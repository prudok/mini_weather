import 'weather_forecast.dart';

class WeatherForecastWeekly {
 WeatherForecast? forecast;
 WeatherForecastWeekly({ this.forecast});

  WeatherForecastWeekly.fromJson(Map<String, dynamic> json) {
    forecast = json['forecast'] != null
        ? WeatherForecast.fromJson(json['forecast'])
        : null;
  }

}

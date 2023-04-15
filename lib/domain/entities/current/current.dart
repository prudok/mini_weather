import '../condition/condition.dart';

class Current {
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  String? windDir;
  double? pressureMb;
  double? precipMm;
  double? feelslikeC;

  Current({
    tempC,
    isDay,
    condition,
    windKph,
    windDir,
    pressureMb,
    precipMm,
    feelslikeC,
  });

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'].toDouble();
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'].toDouble();
    windDir = json['wind_dir'];
    pressureMb = json['pressure_mb'].toDouble();
    precipMm = json['precip_mm'].toDouble();
    feelslikeC = json['feelslike_c'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp_c'] = tempC;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_kph'] = windKph;
    data['wind_dir'] = windDir;
    data['pressure_mb'] = pressureMb;
    data['precip_mm'] = precipMm;
    data['feelslike_c'] = feelslikeC;
    return data;
  }
}

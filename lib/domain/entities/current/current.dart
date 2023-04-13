import '../condition/condition.dart';

class Current {
  int? lastUpdatedEpoch;
  String? lastUpdated;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windMph;
  double? windKph;
  double? windDegree;
  String? windDir;
  int? pressureMb;
  double? pressureIn;
  double? precipMm;
  double? precipIn;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  int? feelslikeF;
  int? visKm;
  int? visMiles;
  int? uv;
  double? gustMph;
  double? gustKph;

  Current(
      {lastUpdatedEpoch,
      lastUpdated,
      tempC,
      tempF,
      isDay,
      condition,
      windMph,
      windKph,
      windDegree,
      windDir,
      pressureMb,
      pressureIn,
      precipMm,
      precipIn,
      humidity,
      cloud,
      feelslikeC,
      feelslikeF,
      visKm,
      visMiles,
      uv,
      gustMph,
      gustKph});

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdatedEpoch = json['last_updated_epoch'];
    lastUpdated = json['last_updated'];
    tempC = json['temp_c'].toDouble();
    // tempF = json['temp_f'].toDouble();
    // isDay = json['is_day'];
    // condition = json['condition'] != null
    //     ? Condition.fromJson(json['condition'])
    //     : null;
    // windMph = json['wind_mph'].toDouble();
    // windKph = json['wind_kph'].toDouble();
    // windDegree = json['wind_degree'].toDouble();
    // windDir = json['wind_dir'];
    // pressureMb = json['pressure_mb'];
    // pressureIn = json['pressure_in'];
    // precipMm = json['precip_mm'];
    // precipIn = json['precip_in'];
    // humidity = json['humidity'];
    // cloud = json['cloud'];
    // feelslikeC = json['feelslike_c'];
    // feelslikeF = json['feelslike_f'];
    // visKm = json['vis_km'];
    // visMiles = json['vis_miles'];
    // uv = json['uv'];
    // gustMph = json['gust_mph'];
    // gustKph = json['gust_kph'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_updated_epoch'] = lastUpdatedEpoch;
    data['last_updated'] = lastUpdated;
    data['temp_c'] = tempC;
    data['temp_f'] = tempF;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_mph'] = windMph;
    data['wind_kph'] = windKph;
    data['wind_degree'] = windDegree;
    data['wind_dir'] = windDir;
    data['pressure_mb'] = pressureMb;
    data['pressure_in'] = pressureIn;
    data['precip_mm'] = precipMm;
    data['precip_in'] = precipIn;
    data['humidity'] = humidity;
    data['cloud'] = cloud;
    data['feelslike_c'] = feelslikeC;
    data['feelslike_f'] = feelslikeF;
    data['vis_km'] = visKm;
    data['vis_miles'] = visMiles;
    data['uv'] = uv;
    data['gust_mph'] = gustMph;
    data['gust_kph'] = gustKph;
    return data;
  }
}

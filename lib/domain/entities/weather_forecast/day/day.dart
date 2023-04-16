
import '../../condition/condition.dart';

class Day {
  double? maxtempC;
  double? mintempC;
  // double? avgtempC;
  // double? maxwindKph;
  // double? totalprecipMm;
  // int? dailyWillItRain;
  // int? dailyChanceOfRain;
  // int? dailyWillItSnow;
  // int? dailyChanceOfSnow;
  Condition? condition;

  Day({
    this.maxtempC,
    this.mintempC,
    // this.avgtempC,
    // this.maxwindKph,
    // this.totalprecipMm,
    // this.dailyWillItRain,
    // this.dailyChanceOfRain,
    // this.dailyWillItSnow,
    // this.dailyChanceOfSnow,
    this.condition,
  });

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'].toDouble();
    mintempC = json['mintemp_c'].toDouble();
    // avgtempC = json['avgtemp_c'];
    // maxwindKph = json['maxwind_kph'];
    // totalprecipMm = json['totalprecip_mm'];
    // dailyWillItRain = json['daily_will_it_rain'];
    // dailyChanceOfRain = json['daily_chance_of_rain'];
    // dailyWillItSnow = json['daily_will_it_snow'];
    // dailyChanceOfSnow = json['daily_chance_of_snow'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maxtemp_c'] = maxtempC;
    data['mintemp_c'] = mintempC;
    // data['avgtemp_c'] = avgtempC;
    // data['maxwind_kph'] = maxwindKph;
    // data['totalprecip_mm'] = totalprecipMm;
    // data['daily_will_it_rain'] = dailyWillItRain;
    // data['daily_chance_of_rain'] = dailyChanceOfRain;
    // data['daily_will_it_snow'] = dailyWillItSnow;
    // data['daily_chance_of_snow'] = dailyChanceOfSnow;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    return data;
  }
}
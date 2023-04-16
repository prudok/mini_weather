import '../day/day.dart';

class Forecastday {
  String? date;
  Day? day;

  Forecastday({
    this.date,
    this.day,
  });

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (day != null) {
      data['day'] = day!.toJson();
    }
    return data;
  }
}

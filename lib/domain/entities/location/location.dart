class Location {
  String? name;
  String? region;
  String? country;
  String? localtime;

  Location({name, region, country, localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['region'] = region;
    data['country'] = country;
    data['localtime'] = localtime;
    return data;
  }
}

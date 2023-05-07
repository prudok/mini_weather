class StatusCodes {
  static const List<int> cloudy = [1063, 1003];
  static const List<int> sunny = [1000];
  static const List<int> rainy = [1189, 1180, 1192, 1195, 1183];

  static bool isCloudy(int? code) {
    if (code == null) {
      return false;
    } else if (cloudy.contains(code)) {
      return true;
    }
    return false;
  }

  static bool isSunny(int? code) {
    if (code == null) {
      return false;
    } else if (sunny.contains(code)) {
      return true;
    }
    return false;
  }

  static bool isRainy(int? code) {
    if (code == null) {
      return false;
    } else if (rainy.contains(code)) {
      return true;
    }
    return false;
  }
}

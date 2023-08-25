class WeeklyWeatherModel {
  final List<DailyWeatherModel> dailyWeather;

  WeeklyWeatherModel({
    required this.dailyWeather,
  });

  factory WeeklyWeatherModel.parseDaysFromJson(Map jsonDays) {
    return WeeklyWeatherModel(
        dailyWeather: DailyWeatherModel.parseDays(jsonDays));
  }
}

class DailyWeatherModel {
  final String time;
  final double temperatureMax;
  final double temperatureMin;
  final int weathercode;
  final double windspeed;

  DailyWeatherModel({
    required this.temperatureMax,
    required this.temperatureMin,
    required this.time,
    required this.weathercode,
    required this.windspeed,
  });

  static List<DailyWeatherModel> parseDays(Map jsonDays) {
    List<DailyWeatherModel> days = [];

    for (var i = 0; i < 7; i++) {
      days.add(DailyWeatherModel(
        temperatureMax: jsonDays['temperature_2m_max'][i],
        temperatureMin: jsonDays['temperature_2m_min'][i],
        time: jsonDays['time'][i],
        weathercode: jsonDays['weathercode'][i],
        windspeed: jsonDays['windspeed_10m_max'][i],
      ));
    }
    return days;
  }
}

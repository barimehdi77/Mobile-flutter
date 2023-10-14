import 'package:intl/intl.dart';

class TodayWeatherModel {
  final List<HourlyWeatherModel> hourlyWeather;

  TodayWeatherModel({
    required this.hourlyWeather,
  });

  factory TodayWeatherModel.paresHoursFromJson(Map jsonHours) {
    return TodayWeatherModel(
      hourlyWeather: HourlyWeatherModel.parseHours(jsonHours),
    );
  }
}

class HourlyWeatherModel {
  final String time;
  final double temperature;
  final int weathercode;
  final double windspeed;

  HourlyWeatherModel({
    required this.temperature,
    required this.time,
    required this.weathercode,
    required this.windspeed,
  });

  static List<HourlyWeatherModel> parseHours(Map jsonHours) {
    List<HourlyWeatherModel> hours = [];

    for (var i = 0; i < 24; i++) {
      // print(jsonHours['time'][i]);
      // var inputDate = DateFormat();
      var parseDate = DateTime.parse(jsonHours['time'][i]);
      print(parseDate);

      var outputFormat = DateFormat('HH:mm');
      var outputDate = outputFormat.format(parseDate);
      hours.add(HourlyWeatherModel(
        temperature: jsonHours['temperature_2m'][i],
        time: outputDate,
        weathercode: jsonHours['weathercode'][i],
        windspeed: jsonHours['windspeed_10m'][i],
      ));
    }
    return hours;
  }
}

import 'package:weatherappv2_proj/models/current_weather_model.dart';

class WeatherModel {
  double latitude;
  double longitude;
  CurrentWeatherModel currentWeather;

  WeatherModel({
    required this.currentWeather,
    required this.latitude,
    required this.longitude,
  });

  factory WeatherModel.fromJson(Map parseData) {
    return WeatherModel(
      currentWeather:
          CurrentWeatherModel.fromJson(parseData['current_weather']),
      latitude: parseData['latitude'],
      longitude: parseData['longitude'],
    );
  }
}

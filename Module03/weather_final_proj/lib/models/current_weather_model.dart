class WeaderDecoder {
  final String name;
  final String icon;

  WeaderDecoder({
    required this.name,
    required this.icon,
  });
}

class CurrentWeatherModel {
  double temperature;
  double windspeed;
  int winddirection;
  int weathercode;

  CurrentWeatherModel({
    required this.temperature,
    required this.weathercode,
    required this.winddirection,
    required this.windspeed,
  });

  factory CurrentWeatherModel.fromJson(Map parseData) {
    return CurrentWeatherModel(
      temperature: parseData['temperature'],
      weathercode: parseData['weathercode'],
      winddirection: parseData['winddirection'],
      windspeed: parseData['windspeed'],
    );
  }

  static WeaderDecoder weatherCodeDecode(int weathercode) {
    switch (weathercode) {
      case 0:
        return WeaderDecoder(
          name: "Clear sky",
          icon: "assets/lotties/clearSky.json",
        );
      case 1:
        return WeaderDecoder(
          name: "Mainly clear",
          icon: "assets/lotties/clearSky.json",
        );
      case 2:
        return WeaderDecoder(
          name: "partly cloudy",
          icon: "assets/lotties/partlyCloudy.json",
        );
      case 3:
        return WeaderDecoder(
          name: "overcast",
          icon: "assets/lotties/partlyCloudy.json",
        );
      case 45:
        return WeaderDecoder(
          name: "Fog",
          icon: "assets/lotties/partlyCloudy.json",
        );
      case 48:
        return WeaderDecoder(
          name: "depositing rime fog",
          icon: "assets/lotties/partlyCloudy.json",
        );
      case 51:
        return WeaderDecoder(
          name: "Light drizzle",
          icon: "assets/lotties/partlyCloudy.json",
        );
      case 53:
        return WeaderDecoder(
          name: "Moderate drizzle",
          icon: "assets/lotties/partlyCloudy.json",
        );
      case 55:
        return WeaderDecoder(
          name: "Dense intensity Drizzle",
          icon: "assets/lotties/partlyCloudy.json",
        );
      case 56:
        return WeaderDecoder(
          name: "Light freezing Drizzle",
          icon: "assets/lotties/partlyCloudy.json",
        );
      case 57:
        return WeaderDecoder(
          name: "Dense intensity freezing Drizzle",
          icon: "assets/lotties/partlyCloudy.json",
        );
      case 61:
        return WeaderDecoder(
          name: "Slight rain",
          icon: "assets/lotties/sloghtRain.json",
        );
      case 63:
        return WeaderDecoder(
          name: "Moderate rain",
          icon: "assets/lotties/sloghtRain.json",
        );
      case 65:
        return WeaderDecoder(
          name: "Heavy intensity rain",
          icon: "assets/lotties/sloghtRain.json",
        );
      case 66:
        return WeaderDecoder(
          name: "Light freezing rain",
          icon: "assets/lotties/sloghtRain.json",
        );
      case 67:
        return WeaderDecoder(
          name: "Heavy intensity freezing rain",
          icon: "assets/lotties/sloghtRain.json",
        );
      case 71:
        return WeaderDecoder(
          name: "Slight Snow fall",
          icon: "assets/lotties/slightSnowFall.json",
        );
      case 73:
        return WeaderDecoder(
          name: "moderate Snow fall",
          icon: "assets/lotties/slightSnowFall.json",
        );
      case 75:
        return WeaderDecoder(
          name: "heavy intensity Snow fall",
          icon: "assets/lotties/slightSnowFall.json",
        );
      case 77:
        return WeaderDecoder(
          name: "Snow grains",
          icon: "assets/lotties/slightSnowFall.json",
        );
      case 80:
        return WeaderDecoder(
          name: "Slight rain showers",
          icon: "assets/lotties/slightSnowFall.json",
        );
      case 81:
        return WeaderDecoder(
          name: "moderate rain showers",
          icon: "assets/lotties/slightSnowFall.json",
        );
      case 82:
        return WeaderDecoder(
          name: "violent rain showers",
          icon: "assets/lotties/slightSnowFall.json",
        );
      case 85:
        return WeaderDecoder(
          name: "slight snow showers",
          icon: "assets/lotties/slightSnowFall.json",
        );
      case 86:
        return WeaderDecoder(
          name: "heavy snow showers",
          icon: "assets/lotties/slightSnowFall.json",
        );
      case 95:
        return WeaderDecoder(
          name: "Thunderstorm",
          icon: "assets/lotties/thunderstorm.json",
        );
      case 96:
        return WeaderDecoder(
          name: "Thunderstorm with slight hail",
          icon: "assets/lotties/thunderstorm.json",
        );
      case 99:
        return WeaderDecoder(
          name: "CThunderstorm with heavy hail",
          icon: "assets/lotties/thunderstorm.json",
        );
      default:
        return WeaderDecoder(
          name: "Unkonw Weather",
          icon: "assets/lotties/thunderstorm.json",
        );
    }
  }
}

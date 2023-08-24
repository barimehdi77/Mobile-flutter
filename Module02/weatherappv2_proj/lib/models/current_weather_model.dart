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

  static String weatherCodeDecode(int weathercode) {
    switch (weathercode) {
      case 0:
        return "Clear sky";
      case 1:
        return "Mainly clear";
      case 2:
        return "partly cloudy";
      case 3:
        return "overcast";
      case 45:
        return "Fog";
      case 48:
        return "depositing rime fog";
      case 51:
        return "Light drizzle";
      case 53:
        return "Moderate drizzle";
      case 55:
        return "Dense intensity Drizzle";
      case 56:
        return "Light freezing Drizzle";
      case 57:
        return "Dense intensity freezing Drizzle";
      case 61:
        return "Slight rain";
      case 63:
        return "Moderate rain";
      case 65:
        return "Heavy intensity rain";
      case 66:
        return "Light freezing rain";
      case 67:
        return "Heavy intensity freezing rain";
      case 71:
        return "Slight Snow fall";
      case 73:
        return "moderate Snow fall";
      case 75:
        return "heavy intensity Snow fall";
      case 77:
        return "Snow grains";
      case 80:
        return "Slight rain showers";
      case 81:
        return "moderate rain showers";
      case 82:
        return "violent rain showers";
      case 85:
        return "slight snow showers";
      case 86:
        return "heavy snow showers";
      case 95:
        return "Thunderstorm";
      case 96:
        return "Thunderstorm with slight hail";
      case 99:
        return "Thunderstorm with heavy hail";
      default:
        return "Unkonw Weather";
    }
  }
}

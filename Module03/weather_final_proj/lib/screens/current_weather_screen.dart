import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_final_proj/models/current_weather_model.dart';
import 'package:weather_final_proj/models/geo_coding_model.dart';
import 'package:weather_final_proj/models/weather_model.dart';

class CurrentWeatherScreen extends StatefulWidget {
  final GeoCodingModel? selectedCity;
  final bool displayGeoLocation;
  final bool isPermissonsAllow;
  final double? latitude;
  final double? longitude;

  const CurrentWeatherScreen({
    super.key,
    required this.selectedCity,
    this.latitude,
    this.longitude,
    this.displayGeoLocation = false,
    this.isPermissonsAllow = false,
  });

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  Future<WeatherModel?> getCurrentWeather() async {
    var url =
        'https://api.open-meteo.com/v1/forecast?latitude=${widget.selectedCity!.latitude}&longitude=${widget.selectedCity!.longitude}&current_weather=true&timezone=auto';
    final dio = Dio();
    final response = await dio.get<Map>(url);

    if (response.statusCode == 200) {
      if (response.data == null) return null;
      return WeatherModel.fromJson(response.data!);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedCity == null) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.isPermissonsAllow)
                const Text(
                  'Currently',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              if (widget.isPermissonsAllow)
                Text(widget.displayGeoLocation == true
                    ? '${widget.latitude} ${widget.longitude}'
                    : ""),
              if (widget.isPermissonsAllow == false)
                const Text(
                  "Geolocation is not available, please enable it in your App settings",
                  style: TextStyle(color: Colors.red, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      );
    }
    return FutureBuilder(
      future: getCurrentWeather(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    widget.selectedCity!.name,
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${widget.selectedCity!.admin1}, ${widget.selectedCity!.country}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Text(
                "${snapshot.data!.currentWeather.temperature} °C",
                style: const TextStyle(
                  fontSize: 77,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    CurrentWeatherModel.weatherCodeDecode(
                      snapshot.data!.currentWeather.weathercode,
                    ).name,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Lottie.asset(
                    CurrentWeatherModel.weatherCodeDecode(
                      snapshot.data!.currentWeather.weathercode,
                    ).icon,
                    width: 300,
                    height: 300,
                    fit: BoxFit.fill,
                  )
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(
                        Icons.air,
                        size: 30,
                        color: Colors.cyan,
                      ),
                    ),
                    TextSpan(
                        text: "${snapshot.data!.currentWeather.windspeed} Km/h",
                        style: const TextStyle(
                          fontSize: 30,
                        )),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Could not find any result for the supplied address or coordinates.",
              softWrap: true,
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

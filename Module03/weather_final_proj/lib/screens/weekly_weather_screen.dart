import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_final_proj/models/current_weather_model.dart';
import 'package:weather_final_proj/models/geo_coding_model.dart';
import 'package:weather_final_proj/models/weekly_weather_model.dart';

class WeeklyWeatherScreen extends StatefulWidget {
  final GeoCodingModel? selectedCity;
  final bool displayGeoLocation;
  final bool isPermissonsAllow;
  final double? latitude;
  final double? longitude;
  const WeeklyWeatherScreen({
    super.key,
    required this.selectedCity,
    this.latitude,
    this.longitude,
    this.displayGeoLocation = false,
    this.isPermissonsAllow = false,
  });

  @override
  State<WeeklyWeatherScreen> createState() => _WeeklyWeatherScreenState();
}

class _WeeklyWeatherScreenState extends State<WeeklyWeatherScreen> {
  Future<WeeklyWeatherModel?> getTodayWeatherByHours() async {
    var url =
        'https://api.open-meteo.com/v1/forecast?latitude=${widget.selectedCity!.latitude}&longitude=${widget.selectedCity!.longitude}&daily=weathercode,temperature_2m_max,temperature_2m_min,windspeed_10m_max&timezone=auto';
    final dio = Dio();
    final response = await dio.get<Map>(url);
    if (response.statusCode == 200) {
      if (response.data == null) return null;
      return WeeklyWeatherModel.parseDaysFromJson(response.data!['daily']);
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
                  'Today',
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
      future: getTodayWeatherByHours(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.selectedCity!.name),
                Text(widget.selectedCity!.admin1),
                Text(widget.selectedCity!.country),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      DailyWeatherModel result =
                          snapshot.data!.dailyWeather[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                result.time,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${result.temperatureMax} °C",
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${result.temperatureMin} °C",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            CurrentWeatherModel.weatherCodeDecode(
                              result.weathercode,
                            ).name,
                            textAlign: TextAlign.center,
                          ),
                          trailing: Text(
                            "${result.windspeed} Km/h",
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.dailyWeather.length,
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
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

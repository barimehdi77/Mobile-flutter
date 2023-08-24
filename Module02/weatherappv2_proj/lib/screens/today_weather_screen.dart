import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weatherappv2_proj/models/current_weather_model.dart';
import 'package:weatherappv2_proj/models/geo_coding_model.dart';
import 'package:weatherappv2_proj/models/today_weather_model.dart';

class TodayWeatherScreen extends StatefulWidget {
  final GeoCodingModel? selectedCity;
  final bool displayGeoLocation;
  final bool isPermissonsAllow;
  final double? latitude;
  final double? longitude;

  const TodayWeatherScreen({
    super.key,
    required this.selectedCity,
    this.latitude,
    this.longitude,
    this.displayGeoLocation = false,
    this.isPermissonsAllow = false,
  });

  @override
  State<TodayWeatherScreen> createState() => _TodayWeatherScreenState();
}

class _TodayWeatherScreenState extends State<TodayWeatherScreen> {
  Future<TodayWeatherModel?> getTodayWeatherByHours() async {
    print('hellp');
    var url =
        'https://api.open-meteo.com/v1/forecast?latitude=${widget.selectedCity!.latitude}&longitude=${widget.selectedCity!.longitude}&hourly=temperature_2m,weathercode,windspeed_10m&timezone=auto&forecast_days=1';
    final dio = Dio();
    final response = await dio.get<Map>(url);
    if (response.statusCode == 200) {
      if (response.data == null) return null;
      return TodayWeatherModel.paresHoursFromJson(response.data!['hourly']);
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
                      HourlyWeatherModel result =
                          snapshot.data!.hourlyWeather[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                result.time.split('T')[1],
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          title: Text(
                            "${result.temperature} °C",
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Text(
                            CurrentWeatherModel.weatherCodeDecode(
                              result.weathercode,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          trailing: Text(
                            "${result.windspeed} Km/h",
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.hourlyWeather.length,
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

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_final_proj/models/current_weather_model.dart';
import 'package:weather_final_proj/models/geo_coding_model.dart';
import 'package:weather_final_proj/models/today_weather_model.dart';
import 'package:weather_final_proj/widgets/today_weather_chart_widget.dart';

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
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1.23,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(
                              height: 37,
                            ),
                            const Text(
                              'Today Temperature',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 37,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, left: 6),
                                child: TodayWeatherChartWidget(
                                  hourlyWeather: snapshot.data!.hourlyWeather,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.hourlyWeather.map((e) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        padding: const EdgeInsets.all(7),
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.time,
                              textAlign: TextAlign.center,
                            ),
                            Lottie.asset(
                              CurrentWeatherModel.weatherCodeDecode(
                                e.weathercode,
                              ).icon,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              "${e.temperature} °C",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: Icon(
                                      Icons.air,
                                      size: 20,
                                      color: Colors.cyan,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${e.windspeed} Km/h",
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // child: Text(result.temperature.toString()),
                      );
                    }).toList(),
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

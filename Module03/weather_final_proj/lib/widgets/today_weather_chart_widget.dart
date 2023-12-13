import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_final_proj/models/today_weather_model.dart';

class TodayWeatherChartWidget extends StatelessWidget {
  const TodayWeatherChartWidget({
    super.key,
    required this.hourlyWeather,
  });

  final List<HourlyWeatherModel> hourlyWeather;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      data,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get data {
    var minTemp = hourlyWeather
        .reduce((prev, element) =>
            element.temperature < prev.temperature ? element : prev)
        .temperature
        .round()
        .toDouble();
    return LineChartData(
      lineTouchData: lineTouchData,
      gridData: gridData,
      titlesData: titlesData,
      borderData: borderData,
      lineBarsData: lineBarsData1,
      minX: 0,
      maxX: 23,
      maxY: hourlyWeather
          .reduce((prev, element) =>
              element.temperature > prev.temperature ? element : prev)
          .temperature
          .round()
          .toDouble(), // change this to the highest degre
      minY: minTemp > 0 ? 0 : minTemp - 1,
    );
  }

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );

    return Text('$value°C', style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 4,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
    );
    Widget text;

    // String valueNumber = value.toStringAsFixed(0);

    // if (value < 10) {
    //   text = Text('0$valueNumber:00', style: style);
    // } else {
    // }
    text = Text(hourlyWeather[value.toInt()].time, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 20,
        interval: 6,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.red, width: 4),
          left: BorderSide(color: Colors.blue, width: 4),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: hourlyWeather
          .map((e) => FlSpot(double.parse(e.time.split(':')[0]), e.temperature))
          .toList());
}

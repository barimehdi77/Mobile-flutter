import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_final_proj/models/weekly_weather_model.dart';

class WeeklyWeatherChartWidget extends StatelessWidget {
  const WeeklyWeatherChartWidget({
    super.key,
    required this.dailyWeather,
  });

  final List<DailyWeatherModel> dailyWeather;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      data,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get data {
    var minTem = dailyWeather
        .reduce((prev, element) =>
            element.temperatureMin < prev.temperatureMin ? element : prev)
        .temperatureMin
        .round()
        .toDouble();
    return LineChartData(
      lineTouchData: lineTouch,
      gridData: gridData,
      titlesData: titles,
      borderData: borderData,
      lineBarsData: lineBarsData,
      minX: 0,
      maxX: 6,
      maxY: dailyWeather
          .reduce((prev, element) =>
              element.temperatureMax > prev.temperatureMax ? element : prev)
          .temperatureMax
          .round()
          .toDouble(), // change this to the highest degre
      minY: minTem > 0 ? 0 : minTem,
    );
  }

  LineTouchData get lineTouch => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titles => FlTitlesData(
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

  List<LineChartBarData> get lineBarsData => [
        lineChartMaxTemperatureData,
        lineChartMinTemperatureData,
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

    text = Text(dailyWeather[value.toInt()].time, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 20,
        interval: 1,
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

  LineChartBarData get lineChartMaxTemperatureData => LineChartBarData(
        isCurved: true,
        color: Colors.red,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: dailyWeather.asMap().entries.map(
          (
            e,
          ) {
            int idx = e.key;
            DailyWeatherModel elem = e.value;
            return FlSpot(idx.toDouble(), elem.temperatureMax);
          },
        ).toList(),
      );
  LineChartBarData get lineChartMinTemperatureData => LineChartBarData(
        isCurved: true,
        color: Colors.blue,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: dailyWeather.asMap().entries.map(
          (
            e,
          ) {
            int idx = e.key;
            DailyWeatherModel elem = e.value;
            return FlSpot(idx.toDouble(), elem.temperatureMin);
          },
        ).toList(),
      );
}

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
    print(hourlyWeather.map((e) => FlSpot(
        e.temperature, double.parse(e.time.split('T')[1].split(':')[0]))));
    print("min");
    print(hourlyWeather
        .reduce((prev, element) =>
            element.temperature < prev.temperature ? element : prev)
        .temperature);
    return LineChart(
      sampleData1,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 24,
        maxY: hourlyWeather
            .reduce((prev, element) =>
                element.temperature > prev.temperature ? element : prev)
            .temperature
            .round()
            .toDouble(), // change this to the highest degre
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
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

    String valueNumber = value.toStringAsFixed(0);

    if (value < 10) {
      text = Text('0$valueNumber:00', style: style);
    } else {
      text = Text('$valueNumber:00', style: style);
    }

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
          .map((e) => FlSpot(
              double.parse(e.time.split('T')[1].split(':')[0]), e.temperature))
          .toList());
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather/models.dart';
import 'package:weather/server.dart';

class HourlyForecastList extends StatelessWidget {
  const HourlyForecastList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forecasts = Server.getHourlyForecast();
    return SliverList(
        delegate: SliverChildListDelegate.fixed([
            Card(child: TemperatureChart(forecasts)),
            Card(child: PrecipitationChart(forecasts)),
            ]),
    );
  }
}

class TemperatureChart extends StatelessWidget {
  final List<HourlyForecast> forecasts;

  const TemperatureChart(this.forecasts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Temperature'),
      primaryXAxis: DateTimeAxis(),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Temp. °C')),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: [
        SplineSeries(
            dataSource: forecasts,
            xValueMapper: (element, index) => element.time,
            yValueMapper: (element, index) => element.temperature_2m,
            legendItemText: 'Air-temp'),
        SplineSeries(
            dataSource: forecasts,
            xValueMapper: (element, index) => element.time,
            yValueMapper: (element, index) => element.apparent_temperature,
            legendItemText: 'Feels-like'),
      ],
    );
  }
}

class PrecipitationChart extends StatelessWidget {
  final List<HourlyForecast> forecasts;
  const PrecipitationChart(this.forecasts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Precipitation'),
      primaryXAxis: DateTimeAxis(),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Precip. mm')),
      series: [
        ColumnSeries(
            dataSource: forecasts,
            xValueMapper: (element, index) => element.time,
            yValueMapper: (element, index) => element.precipitation,
            pointColorMapper: (element, index) => Color.alphaBlend(Colors.red.withOpacity(element.precipitation_probability / 100),
            Colors.green,
            )
        ),
      ],
    );
  }
}

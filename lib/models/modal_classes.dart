import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;
  KeyboardNumber({super.key, required this.onPressed, required this.n});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
      alignment: Alignment.center,
      child: MaterialButton(
          onPressed: onPressed,
          padding: EdgeInsets.all(8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          height: 90,
          child: Text(
            '$n',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28.sp,
                color: Color.fromRGBO(33, 17, 71, 1),
                fontWeight: FontWeight.bold),
          )),
    );
  }
}

class ShadowedBoxes extends StatelessWidget {
  final double height;
  final double width;
  final double padding;
  final double borderRadius;
  final Widget child;
  const ShadowedBoxes(
      {super.key,
      required this.child,
      required this.height,
      required this.width,
      required this.borderRadius,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            border:
                Border.all(width: 0.5, color: Color.fromRGBO(220, 183, 244, 1)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(220, 183, 244, 1), offset: Offset(4, 4))
            ]),
        child: child);
  }
}

class LineChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            color: Colors.white,
            spots: [
              FlSpot(0, 1),
              FlSpot(1, 1.5),
              FlSpot(2, 1.8),
              FlSpot(3, 2.2),
              FlSpot(4, 2.5),
              FlSpot(5, 2.4),
              FlSpot(6, 2.6),
            ],
            isCurved: true,
            barWidth: 2,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: false,
            ),
          ),
        ],
      ),
      duration: Duration(milliseconds: 150), // Optional
      curve: Curves.linear, // Optional
    );
  }
}

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          _createLineData([1, 2, 3, 4, 5], Colors.white),
          _createLineData([5, 4, 3, 2, 1], Colors.black),
        ],
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  LineChartBarData _createLineData(List<double> data, Color color) {
    return LineChartBarData(
      spots: data
          .asMap()
          .entries
          .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
          .toList(),
      isCurved: true,
      barWidth: 2,
      color: Colors.white,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
    );
  }
}

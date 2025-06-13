import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AnalyticsChartWidget extends StatelessWidget {
  final String title;
  final String chartType;

  const AnalyticsChartWidget({
    super.key,
    required this.title,
    required this.chartType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2E7D32),
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              height: 30.h,
              child: _buildChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    switch (chartType) {
      case 'line':
        return _buildLineChart();
      case 'pie':
        return _buildPieChart();
      case 'bar':
        return _buildBarChart();
      default:
        return _buildLineChart();
    }
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withValues(alpha: 0.3),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.withValues(alpha: 0.3),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                Widget text;
                switch (value.toInt()) {
                  case 1:
                    text = const Text('Jan', style: style);
                    break;
                  case 2:
                    text = const Text('Feb', style: style);
                    break;
                  case 3:
                    text = const Text('Mar', style: style);
                    break;
                  case 4:
                    text = const Text('Apr', style: style);
                    break;
                  case 5:
                    text = const Text('May', style: style);
                    break;
                  case 6:
                    text = const Text('Jun', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: text,
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                return Text('\$${value.toInt()}k', style: style);
              },
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        ),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 1),
              FlSpot(2, 4),
              FlSpot(3, 2),
              FlSpot(4, 5),
              FlSpot(5, 3),
              FlSpot(6, 4),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF2E7D32),
                const Color(0xFF4CAF50),
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: const Color(0xFFFFD700),
                  strokeWidth: 2,
                  strokeColor: const Color(0xFF2E7D32),
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2E7D32).withValues(alpha: 0.3),
                  const Color(0xFF4CAF50).withValues(alpha: 0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {},
          enabled: true,
        ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            color: const Color(0xFF2E7D32),
            value: 35,
            title: 'Zakat\n35%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: const Color(0xFF4CAF50),
            value: 25,
            title: 'Sadaqah\n25%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: const Color(0xFFFFD700),
            value: 20,
            title: 'Mosque\n20%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          PieChartSectionData(
            color: const Color(0xFFFFC107),
            value: 20,
            title: 'Other\n20%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 1000,
        barTouchData: BarTouchData(
          enabled: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                );
                Widget text;
                switch (value.toInt()) {
                  case 0:
                    text = const Text('Ahmed', style: style);
                    break;
                  case 1:
                    text = const Text('Fatima', style: style);
                    break;
                  case 2:
                    text = const Text('Omar', style: style);
                    break;
                  case 3:
                    text = const Text('Aisha', style: style);
                    break;
                  case 4:
                    text = const Text('Hassan', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: text,
                );
              },
              reservedSize: 38,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 200,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                return Text('\$${value.toInt()}', style: style);
              },
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 500,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2E7D32),
                    const Color(0xFF4CAF50),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 250,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2E7D32),
                    const Color(0xFF4CAF50),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 1000,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFFD700),
                    const Color(0xFFFFC107),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                toY: 150,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2E7D32),
                    const Color(0xFF4CAF50),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                toY: 300,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2E7D32),
                    const Color(0xFF4CAF50),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

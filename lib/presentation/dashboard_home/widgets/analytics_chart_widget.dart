import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AnalyticsChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> chartData;
  final String currency;

  const AnalyticsChartWidget({
    super.key,
    required this.chartData,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Donation Trends',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Last 7 Days',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Semantics(
              label: "Donation Trends Line Chart",
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 200,
                    getDrawingHorizontalLine: (value) {
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
                            case 0:
                              text = Text('D1', style: style);
                              break;
                            case 1:
                              text = Text('D2', style: style);
                              break;
                            case 2:
                              text = Text('D3', style: style);
                              break;
                            case 3:
                              text = Text('D4', style: style);
                              break;
                            case 4:
                              text = Text('D5', style: style);
                              break;
                            case 5:
                              text = Text('D6', style: style);
                              break;
                            case 6:
                              text = Text('D7', style: style);
                              break;
                            default:
                              text = Text('', style: style);
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
                        interval: 200,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        },
                        reservedSize: 42,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border:
                        Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 1200,
                  lineBarsData: [
                    LineChartBarData(
                      spots: (chartData as List).asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(),
                            (entry.value["amount"] as double));
                      }).toList(),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Color(0xFFFFD700),
                            strokeWidth: 2,
                            strokeColor: Color(0xFF2E7D32),
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF2E7D32).withValues(alpha: 0.3),
                            Color(0xFF4CAF50).withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

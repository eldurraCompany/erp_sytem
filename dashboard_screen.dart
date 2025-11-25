import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

import '../helpers/AppTheme.dart';
import '../helpers/SizeConfig.dart';
import '../locale/MyLocalizations.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static int themeType = 1;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(themeType);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(themeType);

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 800;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(isDesktop),
                    SizedBox(height: 24),
                    _buildMetricsGrid(isDesktop),
                    SizedBox(height: 24),
                    if (isDesktop)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: _buildSalesChart()),
                          SizedBox(width: 24),
                          Expanded(child: _buildRecentActivity()),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _buildSalesChart(),
                          SizedBox(height: 16),
                          _buildRecentActivity(),
                        ],
                      ),
                    SizedBox(height: 24),
                    _buildModulesGrid(isDesktop),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isDesktop ? 32 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Here\'s what\'s happening with your business today',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: isDesktop ? 16 : 14,
                ),
              ),
            ],
          ),
          if (isDesktop)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                MdiIcons.viewDashboard,
                color: Colors.white,
                size: 40,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(bool isDesktop) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: isDesktop ? 4 : 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: isDesktop ? 1.5 : 1.3,
      children: [
        _buildMetricCard(
          'Total Sales',
          '\$125,430',
          '+12.5%',
          Icons.trending_up,
          Color(0xFF4CAF50),
          Color(0xFFE8F5E9),
        ),
        _buildMetricCard(
          'Inventory',
          '1,245',
          '-3.2%',
          MdiIcons.packageVariant,
          Color(0xFF2196F3),
          Color(0xFFE3F2FD),
        ),
        _buildMetricCard(
          'Employees',
          '48',
          '+2',
          MdiIcons.accountGroup,
          Color(0xFFFF9800),
          Color(0xFFFFF3E0),
        ),
        _buildMetricCard(
          'Revenue',
          '\$89,320',
          '+18.3%',
          MdiIcons.currencyUsd,
          Color(0xFF9C27B0),
          Color(0xFFF3E5F5),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String change,
      IconData icon, Color color, Color bgColor) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: change.startsWith('+')
                      ? Color(0xFFE8F5E9)
                      : Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    color: change.startsWith('+')
                        ? Color(0xFF4CAF50)
                        : Color(0xFFF44336),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF718096),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalesChart() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
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
                'Sales Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFF7FAFC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      'Last 7 days',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF718096),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down,
                        size: 16, color: Color(0xFF718096)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Container(
            height: 250,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Color(0xFFE2E8F0),
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
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: Color(0xFF718096),
                          fontSize: 12,
                        );
                        String text;
                        switch (value.toInt()) {
                          case 0:
                            text = 'Mon';
                            break;
                          case 1:
                            text = 'Tue';
                            break;
                          case 2:
                            text = 'Wed';
                            break;
                          case 3:
                            text = 'Thu';
                            break;
                          case 4:
                            text = 'Fri';
                            break;
                          case 5:
                            text = 'Sat';
                            break;
                          case 6:
                            text = 'Sun';
                            break;
                          default:
                            text = '';
                        }
                        return Text(text, style: style);
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '\$${value.toInt()}k',
                          style: TextStyle(
                            color: Color(0xFF718096),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(1, 4),
                      FlSpot(2, 3.5),
                      FlSpot(3, 5),
                      FlSpot(4, 4),
                      FlSpot(5, 5.5),
                      FlSpot(6, 5),
                    ],
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF667EEA).withOpacity(0.3),
                          Color(0xFF764BA2).withOpacity(0.0),
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
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          SizedBox(height: 20),
          _buildActivityItem(
            'New order received',
            '2 minutes ago',
            MdiIcons.shoppingOutline,
            Color(0xFF4CAF50),
          ),
          _buildActivityItem(
            'Payment processed',
            '15 minutes ago',
            MdiIcons.creditCardOutline,
            Color(0xFF2196F3),
          ),
          _buildActivityItem(
            'Inventory updated',
            '1 hour ago',
            MdiIcons.packageVariant,
            Color(0xFFFF9800),
          ),
          _buildActivityItem(
            'New employee added',
            '3 hours ago',
            MdiIcons.accountPlus,
            Color(0xFF9C27B0),
          ),
          _buildActivityItem(
            'Report generated',
            '5 hours ago',
            MdiIcons.fileChartOutline,
            Color(0xFF00BCD4),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
      String title, String time, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModulesGrid(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Access',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: isDesktop ? 4 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildModuleCard(
              'Inventory',
              MdiIcons.packageVariantClosed,
              Color(0xFF3B82F6),
              '/products',
            ),
            _buildModuleCard(
              'Sales',
              MdiIcons.cashRegister,
              Color(0xFF10B981),
              '/sale',
            ),
            _buildModuleCard(
              'HR',
              MdiIcons.accountGroup,
              Color(0xFFF59E0B),
              '/home',
            ),
            _buildModuleCard(
              'Finance',
              MdiIcons.chartLine,
              Color(0xFF8B5CF6),
              '/home',
            ),
            _buildModuleCard(
              'Contacts',
              MdiIcons.contactsOutline,
              Color(0xFFEC4899),
              '/leads',
            ),
            _buildModuleCard(
              'Reports',
              MdiIcons.fileChartOutline,
              Color(0xFF06B6D4),
              '/home',
            ),
            _buildModuleCard(
              'Shipment',
              MdiIcons.truckDelivery,
              Color(0xFFF97316),
              '/shipment',
            ),
            _buildModuleCard(
              'Expenses',
              MdiIcons.receiptTextOutline,
              Color(0xFFEF4444),
              '/expense',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModuleCard(
      String title, IconData icon, Color color, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

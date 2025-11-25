import 'package:flutter/material.dart';

class DataIntegrationGuide {
  static String getInstructions() {
    return '''

═══════════════════════════════════════════════════════════════════════
  CONNECTING REAL DATA TO YOUR DASHBOARD
═══════════════════════════════════════════════════════════════════════

To connect your existing data to the new dashboard, follow these steps:

1. UPDATE DASHBOARD METRICS
   In dashboard_screen.dart, replace sample data in _buildMetricsGrid():

   class _DashboardScreenState extends State<DashboardScreen> {
     double totalSales = 0.0;
     int inventoryCount = 0;
     int employeeCount = 0;
     double revenue = 0.0;

     @override
     void initState() {
       super.initState();
       loadDashboardData();
     }

     Future<void> loadDashboardData() async {
       // Get data from your existing models
       List sells = await SellDatabase().getSells();
       totalSales = sells.fold(0.0, (sum, sell) => sum + sell['invoice_amount']);

       // Get inventory count
       List products = await Variations().getAll();
       inventoryCount = products.length;

       // Get employee count from System
       List users = await System().get('users');
       employeeCount = users.length;

       setState(() {});
     }
   }

2. UPDATE SALES CHART DATA
   Replace sample FlSpot data with actual sales data:

   Future<List<FlSpot>> getSalesChartData() async {
     List<FlSpot> spots = [];
     DateTime now = DateTime.now();

     for (int i = 0; i < 7; i++) {
       DateTime date = now.subtract(Duration(days: 6 - i));
       String dateStr = DateFormat('yyyy-MM-dd').format(date);

       // Get sales for this date
       List daySales = await SellDatabase().getSellsByDate(dateStr);
       double dayTotal = daySales.fold(0.0,
         (sum, sell) => sum + sell['invoice_amount']
       );

       spots.add(FlSpot(i.toDouble(), dayTotal / 1000)); // in thousands
     }

     return spots;
   }

3. UPDATE RECENT ACTIVITY
   Connect to your actual activity log:

   Future<List<Map<String, dynamic>>> getRecentActivities() async {
     List<Map<String, dynamic>> activities = [];

     // Get recent sales
     List recentSells = await SellDatabase()
       .getSells(limit: 5, orderBy: 'created_at DESC');

     for (var sell in recentSells) {
       activities.add({
         'title': 'New order received',
         'time': _formatTime(sell['created_at']),
         'icon': MdiIcons.shoppingOutline,
         'color': Color(0xFF4CAF50),
       });
     }

     return activities;
   }

4. PASS DATA FROM HOME.DART
   Update home.dart to pass data to DashboardScreen:

   // In home.dart build method:
   body: DashboardScreen(
     totalSales: totalSalesAmount,
     totalReceived: totalReceivedAmount,
     totalDue: totalDueAmount,
     salesCount: totalSales,
     userName: userName,
     businessSymbol: businessSymbol,
   ),

   // Update DashboardScreen constructor:
   class DashboardScreen extends StatefulWidget {
     final double totalSales;
     final double totalReceived;
     final double totalDue;
     final int salesCount;
     final String userName;
     final String businessSymbol;

     DashboardScreen({
       this.totalSales = 0.0,
       this.totalReceived = 0.0,
       this.totalDue = 0.0,
       this.salesCount = 0,
       this.userName = '',
       this.businessSymbol = '',
     });
   }

5. USE EXISTING HOME.DART DATA
   Your home.dart already calculates these values:
   - totalSalesAmount
   - totalReceivedAmount
   - totalDueAmount
   - totalSales
   - method (payment methods breakdown)

   Simply pass these to DashboardScreen or recalculate them there.

6. EXAMPLE INTEGRATION:

   // In dashboard_screen.dart
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
           widget.businessSymbol +
             Helper().formatCurrency(widget.totalSales),
           '+12.5%', // Calculate actual change
           Icons.trending_up,
           Color(0xFF4CAF50),
           Color(0xFFE8F5E9),
         ),
         _buildMetricCard(
           'Inventory',
           Helper().formatQuantity(inventoryCount),
           '-3.2%',
           MdiIcons.packageVariant,
           Color(0xFF2196F3),
           Color(0xFFE3F2FD),
         ),
         // ... more cards
       ],
     );
   }

7. REAL-TIME UPDATES
   Add StreamBuilder or FutureBuilder for live data:

   FutureBuilder<List<Map<String, dynamic>>>(
     future: getRecentActivities(),
     builder: (context, snapshot) {
       if (snapshot.hasData) {
         return _buildActivityList(snapshot.data!);
       }
       return CircularProgressIndicator();
     },
   )

8. REFRESH FUNCTIONALITY
   Add pull-to-refresh:

   RefreshIndicator(
     onRefresh: () async {
       await loadDashboardData();
     },
     child: SingleChildScrollView(
       // ... dashboard content
     ),
   )

═══════════════════════════════════════════════════════════════════════
EXAMPLE: Complete Integration
═══════════════════════════════════════════════════════════════════════

// In dashboard_screen.dart - Replace static values with:

class _DashboardScreenState extends State<DashboardScreen> {
  double totalSalesAmount = 0.0;
  int totalSalesCount = 0;
  int inventoryCount = 0;
  double totalReceived = 0.0;
  double totalDue = 0.0;
  List<FlSpot> chartData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  Future<void> loadAllData() async {
    await Future.wait([
      loadSalesData(),
      loadInventoryData(),
      loadChartData(),
    ]);
    setState(() => isLoading = false);
  }

  Future<void> loadSalesData() async {
    List sells = await SellDatabase().getSells();
    totalSalesCount = sells.length;
    totalSalesAmount = sells.fold(0.0,
      (sum, sell) => sum + (sell['invoice_amount'] ?? 0.0)
    );
    totalDue = sells.fold(0.0,
      (sum, sell) => sum + (sell['pending_amount'] ?? 0.0)
    );
    totalReceived = totalSalesAmount - totalDue;
  }

  Future<void> loadInventoryData() async {
    List products = await Variations().getAll();
    inventoryCount = products.length;
  }

  Future<void> loadChartData() async {
    List<FlSpot> spots = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: 6 - i));
      String dateStr = DateFormat('yyyy-MM-dd').format(date);
      List daySells = await SellDatabase().getSellsByDate(dateStr);
      double total = daySells.fold(0.0,
        (sum, sell) => sum + sell['invoice_amount']
      );
      spots.add(FlSpot(i.toDouble(), total / 1000));
    }
    chartData = spots;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: loadAllData,
      child: SingleChildScrollView(
        // ... rest of UI with real data
      ),
    );
  }
}

═══════════════════════════════════════════════════════════════════════

This guide shows you exactly how to connect your existing database and
models to the new dashboard UI. All your existing functionality remains
intact - you're just displaying it in a more beautiful way!

═══════════════════════════════════════════════════════════════════════
    ''';
  }
}

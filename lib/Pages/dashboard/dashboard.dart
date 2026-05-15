import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              const Text(
                "Dashboard",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Welcome back, Arjun! Here's your portfolio overview.",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              // ================= TOP CARDS =================
              Row(
                children: [
                  Expanded(child: _portfolioCard()),
                  const SizedBox(width: 12),
                  Expanded(child: _investedCard()),
                  const SizedBox(width: 12),
                  Expanded(child: _returnsCard()),
                ],
              ),

              const SizedBox(height: 20),

              // ================= MIDDLE =================
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: _payoutCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: _chartCard()),
                ],
              ),

              const SizedBox(height: 20),

              // ================= QUICK ACTIONS =================
              const Text(
                "Quick Actions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(child: 
                  GestureDetector(
                    onTap: () {
                      // Navigate to investments page
                      context.push('/investments');
                    },
                    child: _actionCard(Icons.visibility, "View Investments", Colors.blue))),
                  const SizedBox(width: 12),
                  Expanded(child: 
                  GestureDetector(
                    onTap: () {
                      // Navigate to certificates page
                      context.push('/certificates');
                    },
                    child: _actionCard(Icons.download, "Download Certificates", Colors.green))),
                  const SizedBox(width: 12),
                  Expanded(child: 
                  GestureDetector(
                    onTap: () {
                      // Navigate to support page
                      context.push('/support');
                    },
                    child: _actionCard(Icons.chat_bubble_outline, "Support Chat", Colors.purple))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ================= PORTFOLIO =================
  Widget _portfolioCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff3b82f6), Color(0xff10b981)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Total Portfolio Value",
              style: TextStyle(color: Colors.white70)),
          SizedBox(height: 12),
          Text("₹ 28.34L",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("+12.3% from last month",
              style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  // ================= INVESTED =================
  Widget _investedCard() {
    return _simpleCard(
      title: "Total Invested",
      value: "₹ 28.00L",
      subtitle: "Across 5 active bonds",
    );
  }

  // ================= RETURNS =================
  Widget _returnsCard() {
    return _simpleCard(
      title: "Total Returns Earned",
      value: "₹ 34.0K",
      valueColor: Colors.green,
      subtitle: "Cumulative interest received",
    );
  }

  Widget _simpleCard({
    required String title,
    required String value,
    String? subtitle,
    Color valueColor = Colors.black,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Text(value,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: valueColor)),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),
          ]
        ],
      ),
    );
  }

  // ================= PAYOUT =================
  Widget _payoutCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: Colors.blue, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.blue, size: 18),
              SizedBox(width: 6),
              Text("Next Payout",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          const Text("Due Date", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          const Text("28 Apr 2026",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text("Amount", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          const Text("₹5,125",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ================= CHART =================
  Widget _chartCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Portfolio Growth",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 22),
                      FlSpot(1, 24),
                      FlSpot(2, 26),
                      FlSpot(3, 27),
                      FlSpot(4, 28),
                      FlSpot(5, 29),
                    ],
                    isCurved: true,
                    gradient: const LinearGradient(
                      colors: [Color(0xff3b82f6), Color(0xff10b981)],
                    ),
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= ACTION CARD =================
  Widget _actionCard(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
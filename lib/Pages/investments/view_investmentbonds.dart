import 'package:rd_investment_platform/Pages/investments/investment_details.dart';
import 'package:rd_investment_platform/Pages/investments/payoutsdetails.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:rd_investment_platform/components/investment_kpiboxes.dart';
import 'package:flutter/material.dart';

class ViewInvestmentbonds extends StatelessWidget {
  const ViewInvestmentbonds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: backgroundLight,
        elevation: 0,
        
        toolbarHeight: 80,
        centerTitle: false,
       
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Government Bond Series A',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ministry of Finance',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: textGrey),
            ),
          ],
        ),
      
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Invested
                SizedBox(
                  width: 300,
                  height: 120,
                  child: InvestmentKpiboxes(
                    icon: Icons.currency_rupee,
                    label: 'Invested',
                    value: '₹5,00,000',
                    iconBgColor: const Color(0xFFE7F0FF),
                    iconColor: const Color(0xFF0D63D1),
                  ),
                ),
                const SizedBox(width: 16),
                // Interest Rate
                SizedBox(
                  width: 300,
                  height: 120,
                  child: InvestmentKpiboxes(
                    icon: Icons.trending_up,
                    label: 'Interest Rate',
                    value: '7.5% p.a.',
                    iconBgColor: const Color(0xFFE6F7F0),
                    iconColor: const Color(0xFF00B167),
                  ),
                ),
                const SizedBox(width: 16),
                // Start Date
                SizedBox(
                  width: 300,
                  height: 120,
                  child: InvestmentKpiboxes(
                    icon: Icons.calendar_today_outlined,
                    label: 'Start Date',
                    value: '15 Jan 2024',
                    iconBgColor: const Color(0xFFF3E8FF),
                    iconColor: const Color(0xFF9735FF),
                  ),
                ),
                const SizedBox(width: 16),
                // Maturity
                SizedBox(
                  width: 300,
                  height: 120,
                  child: InvestmentKpiboxes(
                    icon: Icons.access_time,
                    label: 'Maturity',
                    value: '15 Jan 2027',
                    iconBgColor: const Color(0xFFFFF0E6),
                    iconColor: const Color(0xFFFF5700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  SizedBox(width: 600, child: InvestmentDetails()),
                  SizedBox(width: 900, child: PayoutSchedule()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

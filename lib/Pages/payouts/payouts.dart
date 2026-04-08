import 'package:rd_investment_platform/Pages/payouts/payout_history.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:rd_investment_platform/components/payout_kpiboxes.dart';
import 'package:flutter/material.dart';

class Payouts extends StatefulWidget {
  const Payouts({super.key});

  @override
  State<Payouts> createState() => _PayoutsState();
}

class _PayoutsState extends State<Payouts> {
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
              'Coupon Payouts',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Track all your bond interest payments',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: textGrey),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PayoutKpiboxes(
                      icon: Icons.attach_money_outlined,
                      label: 'Total Payouts',
                      value: '₹1,50,000',
                      iconBgColor: const Color.fromARGB(255, 203, 243, 214),
                      iconColor: successGreen,
                      subValue: '3 payments',
                      textColor: successGreen,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: PayoutKpiboxes(
                      icon: Icons.calendar_today_outlined,
                      label: 'Next Payout Date',
                      value: '₹34,000',
                      iconBgColor: const Color(0xFFE7F0FF),
                      iconColor: const Color(0xFF0D63D1),
                      subValue: '3 scheduled',
                      textColor: primaryBlue,
                    ),
                  ),
                  Expanded(
                    child: PayoutKpiboxes(
                      icon: Icons.calendar_today_outlined,
                      label: 'Next Payout Date',
                      value: '₹34,000',
                      iconBgColor: const Color(0xFFE7F0FF),
                      iconColor: const Color(0xFF0D63D1),
                      subValue: '3 scheduled',
                      textColor: primaryBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),

              PayoutHistory(),
            ],
          ),
        ),
      ),
    );
  }
}

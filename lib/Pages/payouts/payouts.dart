import 'package:flutter/material.dart';
import 'package:rd_investment_platform/Pages/payouts/payout_controller.dart';
import 'package:rd_investment_platform/Pages/payouts/payout_history.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:rd_investment_platform/components/payout_kpiboxes.dart';


class Payouts extends StatefulWidget {
  const Payouts({super.key});

  @override
  State<Payouts> createState() => _PayoutsState();
}

class _PayoutsState extends State<Payouts> {
  final PayoutController _controller = PayoutController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
    _controller.fetchPayouts();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: textGrey),
            ),
          ],
        ),
      ),
      body: _controller.loading
          ? const Center(child: CircularProgressIndicator())
          : _controller.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 12),
                      Text('Failed to load payouts',
                          style: TextStyle(
                              color: textDark, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: _controller.fetchPayouts,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _buildBody(),
    );
  }

  Widget _buildBody() {
    final summary = _controller.summary;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Row
            Row(
              children: [
                Expanded(
                  child: PayoutKpiboxes(
                    icon: Icons.attach_money_outlined,
                    label: 'Total Received',
                    value: _controller.formatAmount(summary?.totalPaid ?? 0),
                    iconBgColor: const Color(0xFFCBF3D6),
                    iconColor: successGreen,
                    subValue: '${summary?.paidCount ?? 0} payments',
                    textColor: successGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PayoutKpiboxes(
                    icon: Icons.calendar_today_outlined,
                    label: 'Upcoming Payouts',
                    value: _controller.formatAmount(summary?.totalUpcoming ?? 0),
                    iconBgColor: const Color(0xFFE7F0FF),
                    iconColor: primaryBlue,
                    subValue: '${summary?.upcomingCount ?? 0} scheduled',
                    textColor: primaryBlue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PayoutKpiboxes(
                    icon: Icons.upcoming_outlined,
                    label: 'Next Payout',
                    value: summary?.nextPayout != null
                        ? _controller
                            .formatAmount(summary!.nextPayout!.amount)
                        : '—',
                    iconBgColor: const Color(0xFFFFF0E6),
                    iconColor: const Color(0xFFFF5700),
                    subValue: summary?.nextPayout?.dueDate ?? 'No upcoming',
                    textColor: const Color(0xFFFF5700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // History list
            PayoutHistory(controller: _controller),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
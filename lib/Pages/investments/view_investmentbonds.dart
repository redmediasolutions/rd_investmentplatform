import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rd_investment_platform/Pages/investments/inverstment_model.dart';
import 'package:rd_investment_platform/Pages/investments/investment_details.dart';
import 'package:rd_investment_platform/Pages/investments/payoutsdetails.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:rd_investment_platform/components/investment_kpiboxes.dart';
import 'package:rd_investment_platform/services/api_service.dart';

class ViewInvestmentbonds extends StatefulWidget {
  final InvestmentModel investment;
  const ViewInvestmentbonds({super.key, required this.investment});

  @override
  State<ViewInvestmentbonds> createState() => _ViewInvestmentbondsState();
}

class _ViewInvestmentbondsState extends State<ViewInvestmentbonds> {
  late Future<InvestmentModel> _investmentFuture;
  late Future<Map<String, dynamic>> _payoutsFuture;

  @override
  void initState() {
    super.initState();
    _investmentFuture = ApiService.getInvestmentById(widget.investment.id);
    //_payoutsFuture = ApiService.getPayouts(widget.investment.id);
  }

  String _formatAmount(double amount) {
    if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(2)}L';
    }
    return '₹${amount.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: FutureBuilder<InvestmentModel>(
        future: _investmentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text('Error loading investment',
                      style: TextStyle(color: textDark)),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => context.go('/investments'),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          final inv = snapshot.data!;

          return Scaffold(
            backgroundColor: backgroundLight,
            appBar: AppBar(
              backgroundColor: backgroundLight,
              elevation: 0,
              toolbarHeight: 80,
              centerTitle: false,
              // ← BACK BUTTON
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.arrow_back_ios_new,
                      size: 16, color: textDark),
                ),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/investments');
                  }
                },
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inv.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: textDark,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    inv.issuer,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: textGrey),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // KPI Row — horizontal scroll on small screens
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 260,
                          height: 120,
                          child: InvestmentKpiboxes(
                            icon: Icons.currency_rupee,
                            label: 'Invested',
                            value: _formatAmount(inv.amount),
                            iconBgColor: const Color(0xFFE7F0FF),
                            iconColor: const Color(0xFF0D63D1),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 260,
                          height: 120,
                          child: InvestmentKpiboxes(
                            icon: Icons.trending_up,
                            label: 'Interest Rate',
                            value: '${inv.interestRate}% p.a.',
                            iconBgColor: const Color(0xFFE6F7F0),
                            iconColor: const Color(0xFF00B167),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 260,
                          height: 120,
                          child: InvestmentKpiboxes(
                            icon: Icons.calendar_today_outlined,
                            label: 'Start Date',
                            value: inv.startDate,
                            iconBgColor: const Color(0xFFF3E8FF),
                            iconColor: const Color(0xFF9735FF),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 260,
                          height: 120,
                          child: InvestmentKpiboxes(
                            icon: Icons.access_time,
                            label: 'Maturity',
                            value: inv.maturityDate,
                            iconBgColor: const Color(0xFFFFF0E6),
                            iconColor: const Color(0xFFFF5700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Details + Payouts row
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 900;
                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 340,
                              child: InvestmentDetails(investment: inv),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: PayoutSchedule(
                                payoutsFuture: _payoutsFuture,
                              ),
                            ),
                          ],
                        );
                      }
                      // Stacked on smaller screens
                      return Column(
                        children: [
                          InvestmentDetails(investment: inv),
                          const SizedBox(height: 20),
                          PayoutSchedule(payoutsFuture: _payoutsFuture),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
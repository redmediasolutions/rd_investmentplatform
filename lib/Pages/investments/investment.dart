import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rd_investment_platform/Pages/investments/inverstment_model.dart';
import 'package:rd_investment_platform/Pages/investments/investment_controller.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:rd_investment_platform/components/inverment_bonds.dart';


class Investment extends StatefulWidget {
  const Investment({super.key});

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  final InvestmentController _controller = InvestmentController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
    _controller.fetchInvestments();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatAmount(double amount) {
    if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(2)}L';
    }
    return '₹${amount.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Scaffold(
        backgroundColor: backgroundLight,
        appBar: AppBar(
          leadingWidth: 400,
          backgroundColor: backgroundLight,
          elevation: 0,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Investment Page',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Track and manage all your bond investments',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: textGrey),
              ),
            ],
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_controller.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_controller.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(
              'Failed to load investments',
              style: TextStyle(color: textDark, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _controller.fetchInvestments,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_controller.investments.isEmpty) {
      return Center(
        child: Text(
          'No investments found.',
          style: TextStyle(color: textGrey),
        ),
      );
    }

    return _buildGrid(_controller.investments);
  }

  Widget _buildGrid(List<InvestmentModel> investments) {
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: investments.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.1, // ← fixed overflow
        ),
        itemBuilder: (context, index) {
          final inv = investments[index];
          return GestureDetector(
            onTap: () {
              final id = inv.id;
              if (id == 0) return;
              context.go('/investmentbondsview', extra: id);
            },
            child: InvestmentBonds(
              title: inv.title,
              subtitle: inv.issuer,
              amount: _formatAmount(inv.amount),
              intrestRate: '${inv.interestRate}%',
              maturityDate: inv.maturityDate,
              status: inv.status == 'active' ? 'Active' : inv.status,
              statusColor:
                  inv.status == 'active' ? Colors.green : Colors.grey,
              startdate: inv.startDate,
            ),
          );
        },
      ),
    );
  }
}
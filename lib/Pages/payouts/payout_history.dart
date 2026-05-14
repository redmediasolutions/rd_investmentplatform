import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rd_investment_platform/Pages/payouts/payout_controller.dart';
import 'package:rd_investment_platform/Pages/payouts/request_payout_dialog.dart';
import 'package:rd_investment_platform/Pages/payouts/trasaction_list.dart';

class PayoutHistory extends StatelessWidget {
  final PayoutController controller;

  const PayoutHistory({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0D63D1);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Request Payout + My Requests Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  // ... inside ElevatedButton.icon for 'Request Payout'
                  onPressed: controller.allPayouts.isEmpty
                      ? null // Disable button if there are no payouts at all
                      : () {
                          // Use the first available payout from the 'allPayouts' list
                          // to ensure we have context even if a filter is active.
                          final contextInvestment = controller.allPayouts.first;

                          showDialog(
                            context: context,
                            builder: (_) => RequestPayoutDialog(
                              investmentId: contextInvestment.investmentId,
                              bondName: contextInvestment.investmentTitle,
                              maxAmount: contextInvestment.amount,
                            ),
                          );
                        },
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  label: const Text('Request Payout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.go('/my-requests');
                  },
                  icon: const Icon(Icons.history, size: 18),
                  label: const Text('My Requests'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryBlue,
                    elevation: 0,
                    side: const BorderSide(color: primaryBlue),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Header + Filter
          Row(
            children: [
              Text(
                'Payout History',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),

              _FilterChip(
                label: 'All',
                active: controller.activeFilter == 'all',
                onTap: () => controller.setFilter('all'),
              ),

              const SizedBox(width: 8),

              _FilterChip(
                label: 'Paid',
                active: controller.activeFilter == 'paid',
                onTap: () => controller.setFilter('paid'),
              ),

              const SizedBox(width: 8),

              _FilterChip(
                label: 'Upcoming',
                active: controller.activeFilter == 'upcoming',
                onTap: () => controller.setFilter('upcoming'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Empty State
          if (controller.filteredPayouts.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 50,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No payouts found.',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          // Payout List
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.filteredPayouts.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return TransactionListItem(
                  payout: controller.filteredPayouts[index],
                );
              },
            ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF0D63D1) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }
}

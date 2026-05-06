import 'package:flutter/material.dart';
import 'package:rd_investment_platform/Pages/payouts/payout_controller.dart';
import 'package:rd_investment_platform/Pages/payouts/trasaction_list.dart';


class PayoutHistory extends StatelessWidget {
  final PayoutController controller;
  const PayoutHistory({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
          // Header + filter
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

          if (controller.filteredPayouts.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  'No payouts found.',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
              ),
            )
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
      child: Container(
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
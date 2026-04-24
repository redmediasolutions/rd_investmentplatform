import 'package:flutter/material.dart';
import 'package:rd_investment_platform/Pages/payouts/payout_model.dart';


class TransactionListItem extends StatelessWidget {
  final PayoutModel payout;
  const TransactionListItem({super.key, required this.payout});

  @override
  Widget build(BuildContext context) {
    const Color textDark = Color(0xFF1F2937);
    const Color textGrey = Color(0xFF6B7280);

    final isPaid = payout.status == 'paid';
    final dotColor =
        isPaid ? const Color(0xFF22C55E) : const Color(0xFF3B82F6);
    final tagBg =
        isPaid ? const Color(0xFFDCFCE7) : const Color(0xFFDBEAFE);
    final tagText =
        isPaid ? const Color(0xFF166534) : const Color(0xFF1E40AF);
    final tagLabel = isPaid ? 'Paid' : 'Upcoming';

    final amountFormatted = payout.amount
        .toStringAsFixed(0)
        .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Status dot
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: CircleAvatar(radius: 4, backgroundColor: dotColor),
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  payout.investmentTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _iconText(
                        Icons.calendar_today_outlined,
                        'Due: ${payout.dueDate}',
                        textGrey),
                    if (isPaid && payout.paidDate != null) ...[
                      const SizedBox(width: 16),
                      _iconText(
                          Icons.check_circle_outline,
                          'Paid: ${payout.paidDate}',
                          textGrey),
                    ],
                  ],
                ),
                if (payout.reference != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Transaction: ${payout.reference}',
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF9CA3AF)),
                  ),
                ],
              ],
            ),
          ),

          // Amount + tag
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹$amountFormatted',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: tagBg,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  tagLabel,
                  style: TextStyle(
                      color: tagText,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 13, color: color)),
      ],
    );
  }
}
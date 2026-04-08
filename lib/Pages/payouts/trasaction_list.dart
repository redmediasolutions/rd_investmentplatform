import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({super.key});

  @override
  Widget build(BuildContext context) {
    // Color constants based on the design
    const Color textDark = Color(0xFF1F2937);
    const Color textGrey = Color(0xFF6B7280);
    const Color statusGreen = Color(0xFF22C55E);
    const Color statusBgGreen = Color(0xFFDCFCE7);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6), // Light grey background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Green Status Dot
          const Padding(
            padding: EdgeInsets.only(bottom: 45), // Aligns with the first line of text
            child: CircleAvatar(
              radius: 4,
              backgroundColor: statusGreen,
            ),
          ),
          const SizedBox(width: 12),

          // Main Information Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Government Bond Series A',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildIconText(Icons.calendar_today_outlined, 'Due: 15 Jan 2026', textGrey),
                    const SizedBox(width: 16),
                    _buildIconText(Icons.calendar_today_outlined, 'Paid: 15 Jan 2026', textGrey),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Transaction: TXN2026011501',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9CA3AF), // Lighter grey for transaction ID
                  ),
                ),
              ],
            ),
          ),

          // Price and Tag
          Row(
            children: [
              const Text(
                '₹9,375',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBgGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Paid',
                  style: TextStyle(
                    color: statusGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Small helper for the icon + text layout
  Widget _buildIconText(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: color,
          ),
        ),
      ],
    );
  }
}
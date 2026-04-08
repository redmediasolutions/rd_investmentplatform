import 'package:flutter/material.dart';

class PayoutSchedule extends StatelessWidget {
  const PayoutSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    // Styling constants to keep the build method clean
    const Color textDark = Color(0xFF1F2937);
    const Color textLight = Color(0xFF6B7280);
    const Color borderColor = Color(0xFFE5E7EB);

    return Container(
      width: 700,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- HEADER SECTION ---
          Row(
            children: const [
              Icon(Icons.trending_up, color: Color(0xFF22C55E), size: 20),
              SizedBox(width: 8),
              Text(
                'Payout Schedule',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildLegend(color: const Color(0xFF22C55E), text: 'Paid: ₹9,375'),
              const SizedBox(width: 16),
              _buildLegend(color: const Color(0xFFF59E0B), text: 'Upcoming: ₹9,375'),
            ],
          ),
          const SizedBox(height: 24),

          // --- LIST ITEM 1 (PAID) ---
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: CircleAvatar(radius: 4, backgroundColor: Color(0xFF22C55E)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('₹9,375', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('Due: 15 Jan 2026', style: TextStyle(color: textDark, fontSize: 14)),
                      const Text('Ref: TXN2026011501', style: TextStyle(color: textLight, fontSize: 12)),
                    ],
                  ),
                ),
                _buildStatusTag(text: 'paid', bgColor: const Color(0xFFDCFCE7), textColor: const Color(0xFF166534)),
              ],
            ),
          ),

          // --- LIST ITEM 2 (UPCOMING) ---
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: CircleAvatar(radius: 4, backgroundColor: Color(0xFF3B82F6)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('₹9,375', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Due: 15 Apr 2026', style: TextStyle(color: textDark, fontSize: 14)),
                    ],
                  ),
                ),
                _buildStatusTag(text: 'upcoming', bgColor: const Color(0xFFDBEAFE), textColor: const Color(0xFF1E40AF)),
              ],
            ),
          ),
          
          // Bottom spacing to match image
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  // Small helper UI methods (not separate widgets) to keep the code DRY
  Widget _buildLegend({required Color color, required String text}) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildStatusTag({required String text, required Color bgColor, required Color textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
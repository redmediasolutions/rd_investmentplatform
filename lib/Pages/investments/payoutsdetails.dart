import 'package:flutter/material.dart';
import 'package:rd_investment_platform/Pages/payouts/payout_model.dart';

class PayoutSchedule extends StatelessWidget {
  final Future<Map<String, dynamic>> payoutsFuture;
  const PayoutSchedule({super.key, required this.payoutsFuture});

  @override
  Widget build(BuildContext context) {
    const Color textDark = Color(0xFF1F2937);
    const Color textLight = Color(0xFF6B7280);
    const Color borderColor = Color(0xFFE5E7EB);

    return FutureBuilder<Map<String, dynamic>>(
      future: payoutsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final payouts = (snapshot.data!['payouts'] as List)
            .map((e) => PayoutModel.fromJson(e))
            .toList();
        final summary = snapshot.data!['summary'];
        final totalPaid = summary['total_paid'];
        final totalUpcoming = summary['total_upcoming'];

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.trending_up, color: Color(0xFF22C55E), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Payout Schedule',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textDark),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildLegend(
                      color: const Color(0xFF22C55E),
                      text: 'Paid: ₹${_fmt(totalPaid)}'),
                  const SizedBox(width: 16),
                  _buildLegend(
                      color: const Color(0xFFF59E0B),
                      text: 'Upcoming: ₹${_fmt(totalUpcoming)}'),
                ],
              ),
              const SizedBox(height: 24),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: payouts.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final payout = payouts[index];
                  final isPaid = payout.status == 'paid';
                  return Container(
                    padding: const EdgeInsets.all(20),
                    color: const Color(0xFFF9FAFB),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: isPaid
                                ? const Color(0xFF22C55E)
                                : const Color(0xFF3B82F6),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹${_fmt(payout.amount)}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text('Due: ${payout.dueDate}',
                                  style: const TextStyle(
                                      color: textDark, fontSize: 14)),
                              if (payout.reference != null)
                                Text('Ref: ${payout.reference}',
                                    style: const TextStyle(
                                        color: textLight, fontSize: 12)),
                            ],
                          ),
                        ),
                        _buildStatusTag(
                          text: payout.status,
                          bgColor: isPaid
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFDBEAFE),
                          textColor: isPaid
                              ? const Color(0xFF166534)
                              : const Color(0xFF1E40AF),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _fmt(dynamic amount) {
    final n = double.tryParse(amount.toString()) ?? 0;
    return n.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
  }

  Widget _buildLegend({required Color color, required String text}) {
    return Row(
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildStatusTag(
      {required String text,
      required Color bgColor,
      required Color textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(text,
          style: TextStyle(
              color: textColor, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
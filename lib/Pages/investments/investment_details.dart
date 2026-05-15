import 'package:rd_investment_platform/Pages/investments/inverstment_model.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:flutter/material.dart';

class InvestmentDetails extends StatelessWidget {
  final InvestmentModel investment;
  const InvestmentDetails({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.business_center_outlined,
                  size: 20,
                  color: primaryBlue,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Investment Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _detailRow('Bond ID', investment.bondId.toString()),
          Divider(height: 40, thickness: 1, color: Colors.grey.shade100),
          _detailRow('Issuer', investment.issuer),
          Divider(height: 40, thickness: 1, color: Colors.grey.shade100),
          _detailRow(
            'Payout Frequency',
            _capitalize(investment.payoutFrequency),
          ),
          Divider(height: 40, thickness: 1, color: Colors.grey.shade100),
          Text('Status', style: TextStyle(color: textGrey, fontSize: 14)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: investment.status == 'active'
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _capitalize(investment.status),
              style: TextStyle(
                color: investment.status == 'active'
                    ? const Color(0xFF2E7D32)
                    : Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 32),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download, size: 20, color: textDark),
                const SizedBox(width: 8),
                Text(
                  'Download Certificate',
                  style: TextStyle(
                    color: textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: textGrey, fontSize: 14)),
        const SizedBox(height: 8),
        Text(
          value?.toString() ?? '-',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
        ),
      ],
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

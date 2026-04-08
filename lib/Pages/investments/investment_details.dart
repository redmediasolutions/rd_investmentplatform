import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:flutter/material.dart';


class InvestmentDetails extends StatelessWidget {
  const InvestmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Fixed width to match card-like appearance
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
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.business_center_outlined, // Closer to the bond icon
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
    
          // Bond ID Section
           Text('Bond ID', style: TextStyle(color: textGrey, fontSize: 14)),
          const SizedBox(height: 8),
           Text(
            'inv-001',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDark),
          ),
          Divider(height: 40, thickness: 1, color: Colors.grey.shade100),
    
          // Issuer Section
           Text('Issuer', style: TextStyle(color: textGrey, fontSize: 14)),
          const SizedBox(height: 8),
           Text(
            'Ministry of Finance',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDark),
          ),
          Divider(height: 40, thickness: 1, color: Colors.grey.shade100),
    
          // Payout Frequency Section
           Text('Payout Frequency', style: TextStyle(color: textGrey, fontSize: 14)),
          const SizedBox(height: 8),
           Text(
            'Quarterly',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDark),
          ),
          Divider(height: 40, thickness: 1, color: Colors.grey.shade100),
    
          // Status Section
           Text('Status', style: TextStyle(color: textGrey, fontSize: 14)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Active',
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 32),
    
          // Download Button
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download, size: 20, color: textDark),
                SizedBox(width: 8),
                Text(
                  'Download Certificate',
                  style: TextStyle(color: textDark, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
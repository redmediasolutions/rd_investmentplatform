import 'package:flutter/material.dart';

class PayoutKpiboxes extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color textColor;
  final Color iconBgColor; // Added to match different category colors
  final Color iconColor;
  final String? subValue; // Optional sub-value for additional info

  const PayoutKpiboxes({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconBgColor = const Color(0xFFE7F0FF), // Default light blue
    this.iconColor = const Color(0xFF0D63D1),
    this.subValue, 
    required this.textColor, // Default primary blue
  });

  @override
  Widget build(BuildContext context) {
    return Container(
   
      padding:EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          24,
        ), // Matches cardTheme in appTheme
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container with light background
          Row(
            spacing: 15,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 24, color: iconColor),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (subValue != null) ...[
            const SizedBox(height: 4),
            Text(
              subValue!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
               color: Colors.grey.shade700,
              ),
            ),
          ],

          // Label and Value Column
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InvestmentKpiboxes extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconBgColor; // Added to match different category colors
  final Color iconColor;

  const InvestmentKpiboxes({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconBgColor = const Color(0xFFE7F0FF), // Default light blue
    this.iconColor = const Color(0xFF0D63D1),   // Default primary blue
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24), // Matches cardTheme in appTheme
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon Container with light background
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 24, color: iconColor),
          ),
          const SizedBox(width: 16),
          // Label and Value Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: const Color(0xFF6C757D), // textGrey
                ),
              ),
              const SizedBox(height: 5),
               Column(
                children: [
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF1A1C1E), // textDark
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            
            ],
          ),
           
        ],
      ),
    );
  }
}
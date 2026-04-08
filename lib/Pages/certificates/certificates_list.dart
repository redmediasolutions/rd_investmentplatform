import 'package:flutter/material.dart';

class CertificatesList extends StatelessWidget {
  const CertificatesList({super.key});

  @override
  Widget build(BuildContext context) {
    // Color constants based on the design
    const Color textDark = Color(0xFF1F2937);
    const Color textGrey = Color(0xFF6B7280);
    const Color statusGreen = Color(0xFF22C55E);

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
            padding: EdgeInsets.only(
              bottom: 45,
            ), // Aligns with the first line of text
            child: CircleAvatar(radius: 4, backgroundColor: statusGreen),
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
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Certificate No: GB-2024-001-A',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 138, 139, 140),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildIconText(
                      Icons.calendar_today_outlined,
                      'Issued: 15 Jan 2026',
                      textGrey,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Price and Tag
          GestureDetector(
            onTap: () {
              // Action for downloading PDF
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                // Gradient from Blue (left) to Green (right)
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0D63D1), // Blue
                    Color(0xFF00B167), // Green
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.file_download_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Download PDF',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
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
        Text(label, style: TextStyle(fontSize: 14, color: color)),
      ],
    );
  }
}

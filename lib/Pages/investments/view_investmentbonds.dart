import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:rd_investment_platform/components/investment_kpiboxes.dart';
import 'package:flutter/material.dart';

class ViewInvestmentbonds extends StatelessWidget {
  const ViewInvestmentbonds({super.key});

  @override
  Widget build(BuildContext context) {
    const Color textDark = Color(0xFF1F2937);
    const Color textLight = Color(0xFF6B7280);
    const Color borderColor = Color(0xFFE5E7EB);

    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: backgroundLight,
        elevation: 0,

        toolbarHeight: 80,
        centerTitle: false,

        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Government Bond Series A',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ministry of Finance',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: textGrey),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Invested
                Expanded(
                  child: InvestmentKpiboxes(
                    icon: Icons.currency_rupee,
                    label: 'Invested',
                    value: '₹5,00,000',
                    iconBgColor: const Color(0xFFE7F0FF),
                    iconColor: const Color(0xFF0D63D1),
                  ),
                ),
                const SizedBox(width: 16),
                // Interest Rate
                Expanded(
                  child: InvestmentKpiboxes(
                    icon: Icons.trending_up,
                    label: 'Interest Rate',
                    value: '7.5% p.a.',
                    iconBgColor: const Color(0xFFE6F7F0),
                    iconColor: const Color(0xFF00B167),
                  ),
                ),
                const SizedBox(width: 16),
                // Start Date
                Expanded(
                  child: InvestmentKpiboxes(
                    icon: Icons.calendar_today_outlined,
                    label: 'Start Date',
                    value: '15 Jan 2024',
                    iconBgColor: const Color(0xFFF3E8FF),
                    iconColor: const Color(0xFF9735FF),
                  ),
                ),
                const SizedBox(width: 16),
                // Maturity
                Expanded(
                  child: InvestmentKpiboxes(
                    icon: Icons.access_time,
                    label: 'Maturity',
                    value: '15 Jan 2027',
                    iconBgColor: const Color(0xFFFFF0E6),
                    iconColor: const Color(0xFFFF5700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Expanded(
                    child: Container(
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
                                  Icons
                                      .business_center_outlined, // Closer to the bond icon
                                  size: 20,
                                  color: primaryBlue,
                                ),
                              ),
                              const SizedBox(width: 12),
                              //======================Investment Details============================
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
                          Text(
                            'Bond ID',
                            style: TextStyle(color: textGrey, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'inv-001',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textDark,
                            ),
                          ),
                          Divider(
                            height: 40,
                            thickness: 1,
                            color: Colors.grey.shade100,
                          ),

                          // Issuer Section
                          Text(
                            'Issuer',
                            style: TextStyle(color: textGrey, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ministry of Finance',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textDark,
                            ),
                          ),
                          Divider(
                            height: 40,
                            thickness: 1,
                            color: Colors.grey.shade100,
                          ),

                          // Payout Frequency Section
                          Text(
                            'Payout Frequency',
                            style: TextStyle(color: textGrey, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Quarterly',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textDark,
                            ),
                          ),
                          Divider(
                            height: 40,
                            thickness: 1,
                            color: Colors.grey.shade100,
                          ),

                          // Status Section
                          Text(
                            'Status',
                            style: TextStyle(color: textGrey, fontSize: 14),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.download, size: 20, color: textDark),
                                SizedBox(width: 8),
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
                    ),
                  ),

                  //========================================Payout Schedule===================
                  Expanded(
                    child: Container(
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
                              Icon(
                                Icons.trending_up,
                                color: Color(0xFF22C55E),
                                size: 20,
                              ),
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
                              _buildLegend(
                                color: const Color(0xFF22C55E),
                                text: 'Paid: ₹9,375',
                              ),
                              const SizedBox(width: 16),
                              _buildLegend(
                                color: const Color(0xFFF59E0B),
                                text: 'Upcoming: ₹9,375',
                              ),
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
                                  child: CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Color(0xFF22C55E),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '₹9,375',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Due: 15 Jan 2026',
                                        style: TextStyle(
                                          color: textDark,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Text(
                                        'Ref: TXN2026011501',
                                        style: TextStyle(
                                          color: textLight,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _buildStatusTag(
                                  text: 'paid',
                                  bgColor: const Color(0xFFDCFCE7),
                                  textColor: const Color(0xFF166534),
                                ),
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
                                  child: CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Color(0xFF3B82F6),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        '₹9,375',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Due: 15 Apr 2026',
                                        style: TextStyle(
                                          color: textDark,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _buildStatusTag(
                                  text: 'upcoming',
                                  bgColor: const Color(0xFFDBEAFE),
                                  textColor: const Color(0xFF1E40AF),
                                ),
                              ],
                            ),
                          ),

                          // Bottom spacing to match image
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Helper functions for payout schedule
  Widget _buildLegend({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildStatusTag({
    required String text,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

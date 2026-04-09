import 'package:flutter/material.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: backgroundLight,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reports & Analytics',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Generate and download platform reports',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textGrey,
                  ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    child: _KpiCard(
                      value: '6',
                      label: 'Total Investors',
                      icon: Icons.groups_outlined,
                      iconColor: Color(0xFF1E63FF),
                      iconBg: Color(0xFFE7F0FF),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _KpiCard(
                      value: '5',
                      label: 'Active Bonds',
                      icon: Icons.trending_up_rounded,
                      iconColor: Color(0xFF00B167),
                      iconBg: Color(0xFFDFF7EA),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _KpiCard(
                      value: '6',
                      label: 'Total Payouts',
                      icon: Icons.attach_money_rounded,
                      iconColor: Color(0xFFFF8A00),
                      iconBg: Color(0xFFFFF1E0),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _KpiCard(
                      value: 'Rs. 34.3Cr',
                      label: 'Total AUM',
                      icon: Icons.show_chart_rounded,
                      iconColor: Color(0xFF7B4BFF),
                      iconBg: Color(0xFFF0E8FF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: surfaceWhite,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Generate Report',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: textDark,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _SelectField(
                            label: 'Report Type',
                            value: 'Investor Report',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SelectField(
                            label: 'Date Range',
                            value: 'This Month',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.download_rounded, size: 18),
                            label: const Text('Generate Report'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E63FF),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Popular Reports',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(
                    child: _ReportCard(
                      title: 'Bond Performance Report',
                      subtitle: 'Bond-wise subscription and performance data',
                      icon: Icons.description_outlined,
                      iconColor: Color(0xFF7B4BFF),
                      iconBg: Color(0xFFF0E8FF),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _ReportCard(
                      title: 'Monthly Activity Report',
                      subtitle: 'Comprehensive monthly platform activity',
                      icon: Icons.calendar_today_outlined,
                      iconColor: Color(0xFFE53935),
                      iconBg: Color(0xFFFFD8D8),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _ReportCard(
                      title: 'Compliance Report',
                      subtitle: 'KYC status and regulatory compliance data',
                      icon: Icons.fact_check_outlined,
                      iconColor: Color(0xFF00A6C7),
                      iconBg: Color(0xFFE1F7FA),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Analytics Reports',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(
                    child: _ReportCard(
                      title: 'Investor Growth Report',
                      subtitle: 'Monthly investor acquisition and retention metrics',
                      icon: Icons.groups_outlined,
                      iconColor: Color(0xFF1E63FF),
                      iconBg: Color(0xFFE7F0FF),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _ReportCard(
                      title: 'AUM Performance Report',
                      subtitle: 'Assets under management trends and analysis',
                      icon: Icons.trending_up_rounded,
                      iconColor: Color(0xFF00B167),
                      iconBg: Color(0xFFDFF7EA),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _ReportCard(
                      title: 'Payout Summary Report',
                      subtitle: 'Detailed payout history and statistics',
                      icon: Icons.attach_money_rounded,
                      iconColor: Color(0xFFFF8A00),
                      iconBg: Color(0xFFFFF1E0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: surfaceWhite,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Reports',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: textDark,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 14),
                    const _RecentReportRow(
                      title: 'Investor Growth Report - March 2026',
                      meta: 'Generated on 31 March 2026 • 2.4 MB',
                    ),
                    const SizedBox(height: 12),
                    const _RecentReportRow(
                      title: 'Payout Summary - Q1 2026',
                      meta: 'Generated on 30 March 2026 • 1.8 MB',
                    ),
                    const SizedBox(height: 12),
                    const _RecentReportRow(
                      title: 'Bond Performance - February 2026',
                      meta: 'Generated on 1 March 2026 • 3.2 MB',
                    ),
                    const SizedBox(height: 12),
                    const _RecentReportRow(
                      title: 'Monthly Activity Report - February 2026',
                      meta: 'Generated on 1 March 2026 • 4.1 MB',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const _KpiCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textGrey,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 22, color: iconColor),
          ),
        ],
      ),
    );
  }
}

class _SelectField extends StatelessWidget {
  final String label;
  final String value;

  const _SelectField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textGrey,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textDark,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, color: textGrey),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const _ReportCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 22, color: iconColor),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: textDark,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textGrey,
                ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_rounded, size: 18),
              label: const Text('Download'),
              style: OutlinedButton.styleFrom(
                foregroundColor: textDark,
                side: BorderSide(color: Colors.grey.shade300),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentReportRow extends StatelessWidget {
  final String title;
  final String meta;

  const _RecentReportRow({required this.title, required this.meta});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.description_outlined, color: Color(0xFF8B95A1)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  meta,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textGrey,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download_rounded, size: 20),
            color: textDark,
          ),
        ],
      ),
    );
  }
}

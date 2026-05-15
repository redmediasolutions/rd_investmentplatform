import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rd_investment_platform/Pages/investments/inverstment_model.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';

class InvestmentDetails extends StatelessWidget {
  final InvestmentModel investment;
  const InvestmentDetails({super.key, required this.investment});

  Future<void> _downloadCertificate(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('0D63D1'),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'CARE KAPITAL',
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Investment Certificate',
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('B3D4FF'),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromHex('00B167'),
                        borderRadius: pw.BorderRadius.circular(4),
                      ),
                      child: pw.Text(
                        _capitalize(investment.status),
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 30),

              // Certificate title
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      'BOND INVESTMENT CERTIFICATE',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    pw.SizedBox(height: 6),
                    pw.Container(
                      width: 60,
                      height: 2,
                      color: PdfColor.fromHex('0D63D1'),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 30),

              // Bond name highlight box
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('EFF6FF'),
                  border: pw.Border.all(color: PdfColor.fromHex('BFDBFE')),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Bond Name',
                        style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex('6B7280'))),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      investment.title,
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromHex('0D63D1'),
                      ),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Text(
                      'Issued by ${investment.issuer}',
                      style: pw.TextStyle(
                          fontSize: 11, color: PdfColor.fromHex('6B7280')),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 24),

              // Details grid
              pw.Row(
                children: [
                  pw.Expanded(
                      child: _pdfDetailBox(
                          'Bond ID', investment.bondId.toString())),
                  pw.SizedBox(width: 12),
                  pw.Expanded(
                      child: _pdfDetailBox(
                          'Amount Invested', _formatAmount(investment.amount))),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Row(
                children: [
                  pw.Expanded(
                      child: _pdfDetailBox(
                          'Interest Rate', '${investment.interestRate}% p.a.')),
                  pw.SizedBox(width: 12),
                  pw.Expanded(
                      child: _pdfDetailBox('Payout Frequency',
                          _capitalize(investment.payoutFrequency))),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Row(
                children: [
                  pw.Expanded(
                      child:
                          _pdfDetailBox('Start Date', investment.startDate)),
                  pw.SizedBox(width: 12),
                  pw.Expanded(
                      child: _pdfDetailBox(
                          'Maturity Date', investment.maturityDate)),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Row(
                children: [
                  pw.Expanded(
                      child: _pdfDetailBox('Payout Date', '28th of each month')),
                  pw.SizedBox(width: 12),
                  pw.Expanded(child: _pdfDetailBox('Status', _capitalize(investment.status))),
                ],
              ),

              pw.Spacer(),

              // Footer
              pw.Divider(color: PdfColor.fromHex('E5E7EB')),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Care Kapital — Official Investment Certificate',
                    style: pw.TextStyle(
                        fontSize: 9, color: PdfColor.fromHex('9CA3AF')),
                  ),
                  pw.Text(
                    'Generated: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: pw.TextStyle(
                        fontSize: 9, color: PdfColor.fromHex('9CA3AF')),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (_) async => pdf.save(),
      name: 'certificate_${investment.title.replaceAll(' ', '_')}.pdf',
    );
  }

  pw.Widget _pdfDetailBox(String label, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColor.fromHex('E5E7EB')),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label,
              style: pw.TextStyle(
                  fontSize: 9, color: PdfColor.fromHex('6B7280'))),
          pw.SizedBox(height: 4),
          pw.Text(value,
              style: pw.TextStyle(
                  fontSize: 13, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 10000000) {
      return '₹${(amount / 10000000).toStringAsFixed(2)}Cr';
    }
    if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(2)}L';
    }
    return '₹${amount.toStringAsFixed(0)}';
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

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
            onPressed: () => _downloadCertificate(context),
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
}

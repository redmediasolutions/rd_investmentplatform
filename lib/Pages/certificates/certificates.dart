import 'package:rd_investment_platform/Pages/certificates/certificate_history.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:rd_investment_platform/components/certificates_kpiboxes.dart';
import 'package:flutter/material.dart';

class Certificates extends StatelessWidget {
  const Certificates({super.key});

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Certificates',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Download and manage your investment certificates',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: textGrey),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                spacing: 5,
                children: [
                  Expanded(
                    child: CertificatesKpiboxes(
                      icon: Icons.menu_book_outlined,
                      label: 'Total Certificates',
                      iconBgColor: const Color(0xFFE7F0FF),
                      iconColor: const Color(0xFF0D63D1),
                      value: '5',
                    ),
                  ),
                  Expanded(
                    child: CertificatesKpiboxes(
                      icon: Icons.download,
                      label: 'Available Downloads',
                    iconColor: const Color(0xFF00B167), 
  iconBgColor: const Color(0xFFE6F7F0),
                      value: '5',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
          CertificateHistory()
          ],
        ),
      ),
    );
  }
}

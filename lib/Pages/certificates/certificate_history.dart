import 'package:rd_investment_platform/Pages/certificates/certificates_list.dart';
import 'package:flutter/material.dart';

class CertificateHistory extends StatelessWidget {
  const CertificateHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // Very subtle shadow
              blurRadius: 10, // Softness of the shadow
              spreadRadius: 2, // How far the shadow extends
              offset: const Offset(0, 4), // Moves shadow 4px down
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Your Certificates',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: const CertificatesList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

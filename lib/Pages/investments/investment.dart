
import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:rd_investment_platform/components/inverment_bonds.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Investment extends StatefulWidget {
  const Investment({super.key});

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Scaffold(
        backgroundColor:backgroundLight,
        appBar: AppBar(       
          leadingWidth: 300,
          backgroundColor: backgroundLight,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Investment Page',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: textDark,
              )),
               const SizedBox(height: 4),
              Text('Track and manage all your bond investments',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textGrey)),
            ],
          ),
          
        ),
          
        body: SingleChildScrollView(
  child: Column(
    children: [
      GestureDetector(
        onTap: (){
          context.go('/investmentbondsview');
        },
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Lets the parent handle scrolling
          padding: const EdgeInsets.all(16),
          itemCount: 5,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,          
            crossAxisSpacing: 5,       
            mainAxisSpacing: 4,        // Vertical space between boxes
            childAspectRatio: 1.4,      // Adjust this to control the height of the boxes
          ),
          itemBuilder: (context, index) {
            return InvestmentBonds(
              title: 'Govt Bond A',
              subtitle: 'Min. of Finance',
              amount: '5.00L',
              intrestRate: '7.5%',
              maturityDate: '2025-12-31',
              status: 'Active',
              statusColor: Colors.green,
              startdate: '2023-01-01',
            );
          },
        ),
      ),
   
    ],
  ),
),
      ),
    );
  }
}
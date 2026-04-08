import 'package:rd_investment_platform/Pages/payouts/trasaction_list.dart';
import 'package:flutter/material.dart';

class PayoutHistory extends StatelessWidget {
  const PayoutHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
       boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05), // Very subtle shadow
        blurRadius: 10,                        // Softness of the shadow
        spreadRadius: 2,                       // How far the shadow extends
        offset: const Offset(0, 4),            // Moves shadow 4px down
      ),
    ],
  
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Payout History',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Icon(Icons.filter_alt),
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
                child: const TransactionListItem(),
              );
            },
          ),
        ],
      ),
    );
  }
}

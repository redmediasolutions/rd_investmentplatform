class InvestmentModel {

  final int id;

  final String bondId;

  final String title;

  final String issuer;

  final double amount;

  final double interestRate;

  final String payoutFrequency;

  final String startDate;

  final String maturityDate;

  final String status;

  InvestmentModel({
    required this.id,
    required this.bondId,
    required this.title,
    required this.issuer,
    required this.amount,
    required this.interestRate,
    required this.payoutFrequency,
    required this.startDate,
    required this.maturityDate,
    required this.status,
  });

  factory InvestmentModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return InvestmentModel(

      id: json['id'] ?? 0,

      bondId:
          json['bond_id']?.toString() ?? '',

      title:
          json['bond_name'] ?? 'Bond',

      issuer:
          json['issuer'] ?? '',

      amount: double.tryParse(
            json['investment_amount']
                .toString(),
          ) ??
          0,

      interestRate: double.tryParse(
            json['interest_rate']
                .toString(),
          ) ??
          0,

      payoutFrequency:
          json['payout_frequency'] ?? '',

      startDate:
          json['start_date'] ?? '',

      maturityDate:
          json['maturity_date'] ?? '',

      status:
          json['status'] ?? 'inactive',
    );
  }
}
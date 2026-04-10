class InvestmentModel {
  final int id;
  final String bondId;
  final String title;
  final String issuer;
  final double amount;
  final double interestRate;
  final String startDate;
  final String maturityDate;
  final String payoutFrequency;
  final String status;

  InvestmentModel({
    required this.id,
    required this.bondId,
    required this.title,
    required this.issuer,
    required this.amount,
    required this.interestRate,
    required this.startDate,
    required this.maturityDate,
    required this.payoutFrequency,
    required this.status,
  });

factory InvestmentModel.fromJson(Map<String, dynamic> json) {
  return InvestmentModel(
    id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
    bondId: json['bond_id'] ?? '',
    title: json['title'] ?? '',
    issuer: json['issuer'] ?? '',
    amount: double.tryParse(json['amount'].toString()) ?? 0,
    interestRate: double.tryParse(json['interest_rate'].toString()) ?? 0,
    startDate: json['start_date'] ?? '',
    maturityDate: json['maturity_date'] ?? '',
    payoutFrequency: json['payout_frequency'] ?? '',
    status: json['status'] ?? '',
  );
}
}

class PayoutModel {
  final int id;
  final int investmentId;
  final double amount;
  final String dueDate;
  final String? paidDate;
  final String status;
  final String? reference;

  PayoutModel({
    required this.id,
    required this.investmentId,
    required this.amount,
    required this.dueDate,
    this.paidDate,
    required this.status,
    this.reference,
  });

  factory PayoutModel.fromJson(Map<String, dynamic> json) {
    return PayoutModel(
      id: json['id'],
      investmentId: json['investment_id'],
      amount: double.parse(json['amount'].toString()),
      dueDate: json['due_date'],
      paidDate: json['paid_date'],
      status: json['status'],
      reference: json['reference'],
    );
  }
}
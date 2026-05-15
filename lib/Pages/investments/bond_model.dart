class BondModel {
  final int id;
  final String bondName;
  final String issuer;
  final double interestRate;
  final double minInvestment;
  final double maxInvestment;
  final String payoutFrequency;
  final String status;

  BondModel({
    required this.id,
    required this.bondName,
    required this.issuer,
    required this.interestRate,
    required this.minInvestment,
    required this.maxInvestment,
    required this.payoutFrequency,
    required this.status,
  });

  factory BondModel.fromJson(Map<String, dynamic> json) {
    return BondModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      bondName: json['bond_name'] ?? '',
      issuer: json['issuer'] ?? '',
      interestRate: double.tryParse(json['interest_rate'].toString()) ?? 0,
      minInvestment: double.tryParse(json['min_investment'].toString()) ?? 0,
      maxInvestment: double.tryParse(json['max_investment'].toString()) ?? 0,
      payoutFrequency: json['payout_frequency'] ?? 'monthly',
      status: json['status'] ?? 'active',
    );
  }
}

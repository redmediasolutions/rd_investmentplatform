class PayoutModel {
  final int id;
  final int investmentId;
  final String investmentTitle;
  final double amount;
  final String dueDate;
  final String? paidDate;
  final String status;
  final String? reference;

  PayoutModel({
    required this.id,
    required this.investmentId,
    required this.investmentTitle,
    required this.amount,
    required this.dueDate,
    this.paidDate,
    required this.status,
    this.reference,
  });

  factory PayoutModel.fromJson(Map<String, dynamic> json) {
    return PayoutModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      investmentId: json['investment_id'] is int
          ? json['investment_id']
          : int.tryParse(json['investment_id'].toString()) ?? 0,
      investmentTitle: json['investment_title'] ?? '',
      amount: double.tryParse(json['amount'].toString()) ?? 0,
      dueDate: json['due_date'] ?? '',
      paidDate: json['paid_date'],
      status: json['status'] ?? 'upcoming',
      reference: json['reference'],
    );
  }
}

class PayoutSummary {
  final double totalPaid;
  final double totalUpcoming;
  final int paidCount;
  final int upcomingCount;
  final PayoutModel? nextPayout;

  PayoutSummary({
    required this.totalPaid,
    required this.totalUpcoming,
    required this.paidCount,
    required this.upcomingCount,
    this.nextPayout,
  });

  factory PayoutSummary.fromJson(Map<String, dynamic> json) {
    return PayoutSummary(
      totalPaid: double.tryParse(json['total_paid'].toString()) ?? 0,
      totalUpcoming: double.tryParse(json['total_upcoming'].toString()) ?? 0,
      paidCount: json['paid_count'] ?? 0,
      upcomingCount: json['upcoming_count'] ?? 0,
      nextPayout: json['next_payout'] != null
          ? PayoutModel.fromJson(json['next_payout'])
          : null,
    );
  }
}
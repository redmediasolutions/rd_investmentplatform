

class PayoutRequestModel {
  final int id;
  final int investmentId;
  final double amount;
  final String? reason;
  final String status;
  final String? adminNote;
  final String requestedAt;
  final String? reviewedAt;
  final String bondName;

  PayoutRequestModel({
    required this.id,
    required this.investmentId,
    required this.amount,
    this.reason,
    required this.status,
    this.adminNote,
    required this.requestedAt,
    this.reviewedAt,
    required this.bondName,
  });

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';

  String get formattedAmount {
    return '₹${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  factory PayoutRequestModel.fromJson(Map<String, dynamic> json) {
    return PayoutRequestModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      investmentId: json['investment_id'] is int
          ? json['investment_id']
          : int.tryParse(json['investment_id'].toString()) ?? 0,
      amount: double.tryParse(json['amount'].toString()) ?? 0,
      reason: json['reason'],
      status: json['status'] ?? 'pending',
      adminNote: json['admin_note'],
      requestedAt: json['requested_at'] ?? '',
      reviewedAt: json['reviewed_at'],
      bondName: json['bond_name'] ?? '',
    );
  }
}
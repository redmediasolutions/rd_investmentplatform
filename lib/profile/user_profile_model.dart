class UserProfileModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String status;
  final String createdAt;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.status,
    required this.createdAt,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      status: json['status'] ?? 'active',
      createdAt: json['created_at'] ?? '',
    );
  }
}
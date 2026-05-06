import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rd_investment_platform/Pages/investments/inverstment_model.dart';
import 'package:rd_investment_platform/profile/user_profile_model.dart';


class ApiService {
  static const String baseUrl = 'https://api.ip.rd-crm.in';

  static Future<String> _getToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not logged in');
    return await user.getIdToken() ?? '';
  }

  static Future<Map<String, String>> _headers() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Fetch all investments
static Future<List<InvestmentModel>> getInvestments() async {
  final response = await http.get(
    Uri.parse('$baseUrl/investments'),
    headers: await _headers(),
  );
  debugPrint('=== INVESTMENTS STATUS: ${response.statusCode} ===');
  debugPrint('=== INVESTMENTS BODY: ${response.body} ===');
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return (data['investments'] as List)
        .map((e) => InvestmentModel.fromJson(e))
        .toList();
  }
  throw Exception('Failed to load investments');
}

  // Fetch single investment
  static Future<InvestmentModel> getInvestmentById(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/investments/$id'),
      headers: await _headers(),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return InvestmentModel.fromJson(data['investment']);
    }
    throw Exception('Failed to load investment');
  }

  // Fetch payouts for a single investment (used in detail screen)
  static Future<Map<String, dynamic>> getPayouts(int investmentId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/investments/$investmentId/payouts'),
      headers: await _headers(),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load payouts');
  }

  // Fetch ALL payouts across all investments (used in Payouts page)
static Future<Map<String, dynamic>> getAllPayouts() async {
  final headers = await _headers();
  debugPrint('=== TOKEN BEING SENT ===');
  debugPrint(headers['Authorization'] ?? 'NO TOKEN');
  
  final response = await http.get(
    Uri.parse('$baseUrl/payouts'),
    headers: headers,
  );
  
  debugPrint('=== PAYOUTS STATUS: ${response.statusCode} ===');
  debugPrint('=== PAYOUTS BODY: ${response.body} ===');
  
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  throw Exception('Failed to load payouts: ${response.body}');
}

// ── USER PROFILE ───────────────────────────────────────

static Future<UserProfileModel> getUserProfile() async {
  final response = await http.get(
    Uri.parse('$baseUrl/user/profile'),
    headers: await _headers(),
  );
  if (response.statusCode == 200) {
    return UserProfileModel.fromJson(jsonDecode(response.body)['user']);
  }
  throw Exception('Failed to load profile');
}

static Future<void> updateProfile({
  required String name,
  String? phone,
}) async {
  final response = await http.put(
    Uri.parse('$baseUrl/user/profile'),
    headers: await _headers(),
    body: jsonEncode({'name': name, 'phone': phone}),
  );
  if (response.statusCode != 200) {
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Failed to update profile');
  }
}

static Future<void> changePassword(String newPassword) async {
  final response = await http.post(
    Uri.parse('$baseUrl/user/change-password'),
    headers: await _headers(),
    body: jsonEncode({'new_password': newPassword}),
  );
  if (response.statusCode != 200) {
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Failed to change password');
  }
}



}
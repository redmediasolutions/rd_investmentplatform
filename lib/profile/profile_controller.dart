import 'package:flutter/material.dart';
import 'package:rd_investment_platform/profile/user_profile_model.dart';
import 'package:rd_investment_platform/services/api_service.dart';

class ProfileController extends ChangeNotifier {
  UserProfileModel? profile;
  bool loading = false;
  bool saving = false;
  bool changingPassword = false;
  String? error;
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  Future<void> fetchProfile() async {
    loading = true;
    error = null;
    _notify();
    try {
      profile = await ApiService.getUserProfile();
      if (_disposed) return;
    } catch (e) {
      if (_disposed) return;
      error = e.toString();
    } finally {
      loading = false;
      _notify();
    }
  }

  Future<void> updateProfile({
    required String name,
    String? phone,
  }) async {
    saving = true;
    _notify();
    try {
      await ApiService.updateProfile(name: name, phone: phone);
      if (_disposed) return;
      await fetchProfile();
    } catch (e) {
      if (_disposed) return;
      saving = false;
      _notify();
      rethrow;
    }
  }

  Future<void> changePassword(String newPassword) async {
    changingPassword = true;
    _notify();
    try {
      await ApiService.changePassword(newPassword);
      if (_disposed) return;
    } finally {
      changingPassword = false;
      _notify();
    }
  }
}
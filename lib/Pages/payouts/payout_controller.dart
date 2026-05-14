import 'package:flutter/material.dart';
import 'package:rd_investment_platform/Pages/payouts/payout_model.dart';
import 'package:rd_investment_platform/services/api_service.dart';

class PayoutController extends ChangeNotifier {
  List<PayoutModel> allPayouts = [];
  List<PayoutModel> filteredPayouts = [];
  PayoutSummary? summary;
  bool loading = false;
  String? error;
  String activeFilter = 'all';

  // Lifecycle flag to prevent "used after being disposed" error
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  // ========================= FETCH DATA =========================

  Future<void> fetchPayouts() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      // Call API once and store result
      final responseData = await ApiService.getAllPayouts();
      
      debugPrint('=== PAYOUT DATA RECEIVED ===');

      // Update state
      allPayouts = (responseData['payouts'] as List)
          .map((e) => PayoutModel.fromJson(e))
          .toList();
          
      summary = PayoutSummary.fromJson(responseData['summary']);
      
      _applyFilter(activeFilter);
    } catch (e) {
      error = e.toString();
      debugPrint('Payout Fetch Error: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // ========================= FILTERING =========================

  void setFilter(String filter) {
    activeFilter = filter;
    _applyFilter(filter);
    notifyListeners();
  }

  void _applyFilter(String filter) {
    if (filter == 'all') {
      filteredPayouts = List.from(allPayouts);
    } else {
      filteredPayouts = allPayouts.where((p) => p.status == filter).toList();
    }
  }

  // ========================= HELPERS =========================


  String formatAmount(double amount) {
    // Regex for Indian Numbering System (standard 1,00,000 style)
    final formatted = amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d+?)(?=(\d\d)+(\d)(?!\d))|(\d+?)(?=(\d\d\d)+(?!\d))'),
        (Match m) => "${m[1] ?? m[4]},");
    return '₹$formatted';
  }
}
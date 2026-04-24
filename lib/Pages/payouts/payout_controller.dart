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

  Future<void> fetchPayouts() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
          // TEMPORARY DEBUG - remove after fix
    final debugData = await ApiService.getAllPayouts();
    debugPrint('=== PAYOUT RESPONSE ===');
    debugPrint(debugData.toString());
    // END DEBUG


      final data = await ApiService.getAllPayouts();
      allPayouts = (data['payouts'] as List)
          .map((e) => PayoutModel.fromJson(e))
          .toList();
      summary = PayoutSummary.fromJson(data['summary']);
      _applyFilter(activeFilter);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void setFilter(String filter) {
    activeFilter = filter;
    _applyFilter(filter);
    notifyListeners();
  }

  void _applyFilter(String filter) {
    if (filter == 'all') {
      filteredPayouts = List.from(allPayouts);
    } else {
      filteredPayouts =
          allPayouts.where((p) => p.status == filter).toList();
    }
  }

  String formatAmount(double amount) {
    final formatted = amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
    return '₹$formatted';
  }
}
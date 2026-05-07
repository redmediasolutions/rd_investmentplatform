import 'package:flutter/material.dart';
import 'package:rd_investment_platform/Pages/investments/inverstment_model.dart';
import 'package:rd_investment_platform/services/api_service.dart';

class InvestmentController extends ChangeNotifier {
  List<InvestmentModel> investments = [];
  bool loading = false;
  String? error;

  Future<void> fetchInvestments() async {
  loading = true;
  error = null;

  notifyListeners();

  try {

    final data =
        await ApiService.getUserBondInvestments();

    investments = data;

  } catch (e) {

    error = e.toString();

    debugPrint('Investment fetch error: $e');

  } finally {

    loading = false;

    notifyListeners();
  }
}
}
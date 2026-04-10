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
      investments = await ApiService.getInvestments();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
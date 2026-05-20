import 'package:flutter/material.dart';
import 'package:rd_investment_platform/Pages/investments/bond_model.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:rd_investment_platform/services/api_service.dart';

class CreateInvestmentDialog extends StatefulWidget {
  const CreateInvestmentDialog({super.key});

  @override
  State<CreateInvestmentDialog> createState() => _CreateInvestmentDialogState();
}

class _CreateInvestmentDialogState extends State<CreateInvestmentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  List<BondModel> _bonds = [];
  BondModel? _selectedBond;
  int? _userId;
  bool _loadingData = true;
  bool _submitting = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    try {
      final results = await Future.wait([
        ApiService.getBonds(),
        ApiService.getUserProfile(),
      ]);
      final bonds = results[0] as List<BondModel>;
      final profile = results[1] as dynamic;
      if (mounted) {
        setState(() {
          _bonds = bonds;
          _userId = profile.id as int;
          _loadingData = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadError = e.toString();
          _loadingData = false;
        });
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedBond == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a bond')),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      await ApiService.createInvestment(
        userId: _userId!,
        bondId: _selectedBond!.id,
        amount: double.parse(_amountController.text.trim()),
        payoutFrequency: _selectedBond!.payoutFrequency,
      );
      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Investment created successfully'),
            backgroundColor: Color(0xFF00B167),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 480,
        padding: const EdgeInsets.all(28),
        child: _loadingData
            ? const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )
            : _loadError != null
                ? SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.red, size: 40),
                        const SizedBox(height: 12),
                        Text('Failed to load data',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: textDark)),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _loadError = null;
                              _loadingData = true;
                            });
                            _loadInitialData();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.add_chart, color: primaryBlue, size: 22),
              ),
              const SizedBox(width: 12),
              Text(
                'Create Investment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.close, color: textGrey),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Bond Dropdown
          DropdownButtonFormField<BondModel>(
            value: _selectedBond,
            decoration: InputDecoration(
              labelText: 'Select Bond',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            items: _bonds
                .map((b) => DropdownMenuItem(
                      value: b,
                      child: Text(
                        '${b.bondName} — ${b.interestRate}% p.a.',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            onChanged: (bond) => setState(() {
              _selectedBond = bond;
              _amountController.clear();
            }),
            validator: (v) => v == null ? 'Please select a bond' : null,
          ),

          // Min/Max hint shown after bond selection
          if (_selectedBond != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F7FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: primaryBlue),
                  const SizedBox(width: 6),
                  Text(
                    'Min: ${_fmt(_selectedBond!.minInvestment)}   •   Max: ${_fmt(_selectedBond!.maxInvestment)}   •   Payout: ${_capitalize(_selectedBond!.payoutFrequency)}',
                    style: TextStyle(fontSize: 12, color: primaryBlue),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),

          // Investment Amount
          TextFormField(
            controller: _amountController,
            decoration: InputDecoration(
              labelText: 'Investment Amount',
              prefixText: '₹ ',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              final val = double.tryParse(v.trim());
              if (val == null) return 'Enter a valid amount';
              if (_selectedBond != null) {
                if (val < _selectedBond!.minInvestment) {
                  return 'Minimum investment is ${_fmt(_selectedBond!.minInvestment)}';
                }
                if (_selectedBond!.maxInvestment > 0 &&
                    val > _selectedBond!.maxInvestment) {
                  return 'Maximum investment is ${_fmt(_selectedBond!.maxInvestment)}';
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Submit
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _submitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: _submitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text(
                      'Create Investment',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(double amount) {
    if (amount >= 10000000) return '₹${(amount / 10000000).toStringAsFixed(2)}Cr';
    if (amount >= 100000) return '₹${(amount / 100000).toStringAsFixed(2)}L';
    if (amount >= 1000) return '₹${(amount / 1000).toStringAsFixed(0)}K';
    return '₹${amount.toStringAsFixed(0)}';
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

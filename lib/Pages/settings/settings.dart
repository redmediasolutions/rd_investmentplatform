import 'package:flutter/material.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _activeTab = 0; // 0 = General, 1 = Users

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: backgroundLight,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage platform configuration and preferences',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textGrey,
                  ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _SettingsTabs(
                activeIndex: _activeTab,
                onChange: (index) => setState(() => _activeTab = index),
              ),
              const SizedBox(height: 16),
              if (_activeTab == 0) const _GeneralSection() else const _UsersSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTabs extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onChange;

  const _SettingsTabs({required this.activeIndex, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEFF2),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: 'General',
              isActive: activeIndex == 0,
              onTap: () => onChange(0),
            ),
          ),
          Expanded(
            child: _TabButton(
              label: 'Users',
              isActive: activeIndex == 1,
              onTap: () => onChange(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textDark,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }
}

class _GeneralSection extends StatelessWidget {
  const _GeneralSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Platform Information',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: textDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 18),
          const _FieldBox(label: 'Platform Name', value: 'InvestHub'),
          const SizedBox(height: 14),
          const _FieldBox(label: 'Support Email', value: 'support@investhub.com'),
          const SizedBox(height: 14),
          const _FieldBox(label: 'Support Phone', value: '+91 1800 123 4567'),
          const SizedBox(height: 14),
          const _FieldBox(
            label: 'Business Address',
            value: '123 Financial District, Mumbai, Maharashtra 400001',
            height: 72,
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E63FF),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}

class _UsersSection extends StatelessWidget {
  const _UsersSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Users',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: textDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 16),
          const _UserRow(
            name: 'Admin User',
            email: 'admin@investhub.com',
            role: 'Super Admin',
          ),
          const SizedBox(height: 12),
          const _UserRow(
            name: 'Support Manager',
            email: 'support@investhub.com',
            role: 'Admin',
          ),
          const SizedBox(height: 12),
          const _UserRow(
            name: 'Operations Lead',
            email: 'ops@investhub.com',
            role: 'Admin',
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E63FF),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.w700),
              ),
              child: const Text('Add New Admin User'),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldBox extends StatelessWidget {
  final String label;
  final String value;
  final double height;

  const _FieldBox({
    required this.label,
    required this.value,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textDark,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textDark,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UserRow extends StatelessWidget {
  final String name;
  final String email;
  final String role;

  const _UserRow({
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F0FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.groups_outlined,
              color: Color(0xFF1E63FF),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$email • $role',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textGrey,
                      ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: textDark,
              side: BorderSide(color: Colors.grey.shade300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: const Text('Edit'),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFE53935),
              side: BorderSide(color: Colors.red.shade100),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

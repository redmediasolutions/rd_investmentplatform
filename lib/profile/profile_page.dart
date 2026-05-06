import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';
import 'package:rd_investment_platform/profile/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _controller = ProfileController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Password fields
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFormKey = GlobalKey<FormState>();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
        // Populate fields when profile loads
        if (_controller.profile != null &&
            _nameController.text.isEmpty) {
          _nameController.text = _controller.profile!.name;
          _phoneController.text = _controller.profile!.phone ?? '';
        }
      }
    });
    _controller.fetchProfile();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSnack(String msg, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: error ? Colors.red : const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await _controller.updateProfile(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
      );
      _showSnack('Profile updated successfully ✓');
    } catch (e) {
      _showSnack(e.toString().replaceFirst('Exception: ', ''),
          error: true);
    }
  }

  Future<void> _changePassword() async {
    if (!_passwordFormKey.currentState!.validate()) return;
    try {
      await _controller.changePassword(
          _newPasswordController.text.trim());
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      _showSnack('Password changed successfully ✓');
    } catch (e) {
      _showSnack(e.toString().replaceFirst('Exception: ', ''),
          error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: backgroundLight,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(Icons.arrow_back_ios_new,
                size: 16, color: textDark),
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/investments');
            }
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Profile',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                        fontWeight: FontWeight.bold, color: textDark)),
            Text('Manage your account details',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: textGrey)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) context.go('/login');
              },
              icon: const Icon(Icons.logout,
                  size: 18, color: Colors.red),
              label: const Text('Logout',
                  style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
      body: _controller.loading
          ? const Center(child: CircularProgressIndicator())
          : _controller.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 12),
                      Text(_controller.error!),
                      TextButton.icon(
                        onPressed: _controller.fetchProfile,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _profileHeader(),
                          const SizedBox(height: 24),
                          _profileForm(),
                          const SizedBox(height: 24),
                          _passwordForm(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  // ── Profile Header ────────────────────────────────────
  Widget _profileHeader() {
    final profile = _controller.profile;
    return _card(
      child: Row(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryBlue.withOpacity(0.15),
                  primaryBlue.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: primaryBlue.withOpacity(0.2), width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              profile?.initials ?? '?',
              style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.w900,
                  fontSize: 28),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile?.name.isNotEmpty == true
                      ? profile!.name
                      : profile?.email.split('@')[0] ?? '',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: textDark),
                ),
                const SizedBox(height: 4),
                Text(profile?.email ?? '',
                    style:
                        TextStyle(color: textGrey, fontSize: 14)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _badge('Investor',
                        const Color(0xFFDBEAFE), primaryBlue),
                    const SizedBox(width: 8),
                    _badge(
                      profile?.status ?? 'active',
                      profile?.status == 'active'
                          ? const Color(0xFFDCFCE7)
                          : const Color(0xFFF3F4F6),
                      profile?.status == 'active'
                          ? const Color(0xFF16A34A)
                          : textGrey,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Member since
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Member since',
                  style:
                      TextStyle(color: textGrey, fontSize: 12)),
              const SizedBox(height: 4),
              Text(
                profile?.createdAt.substring(0, 10) ?? '',
                style: TextStyle(
                    color: textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Profile Form ──────────────────────────────────────
  Widget _profileForm() {
    return _card(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(
                Icons.person_outline, 'Personal Information'),
            const SizedBox(height: 20),

            // Name
            _fieldLabel('Full Name'),
            TextFormField(
              controller: _nameController,
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Name is required'
                  : null,
              decoration: _inputDecoration(
                  'Enter your full name', Icons.person_outline),
            ),
            const SizedBox(height: 16),

            // Email (read only)
            _fieldLabel('Email Address'),
            TextFormField(
              initialValue: _controller.profile?.email,
              readOnly: true,
              decoration: _inputDecoration(
                      'Email', Icons.email_outlined)
                  .copyWith(
                fillColor: const Color(0xFFF3F4F6),
                suffixIcon: const Icon(Icons.lock_outline,
                    size: 16, color: Color(0xFF9CA3AF)),
              ),
              style: TextStyle(color: textGrey),
            ),
            const SizedBox(height: 16),

            // Phone
            _fieldLabel('Phone Number'),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration(
                  '+91 98765 43210', Icons.phone_outlined),
            ),
            const SizedBox(height: 24),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _controller.saving ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: _controller.saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Save Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Password Form ─────────────────────────────────────
  Widget _passwordForm() {
    return _card(
      child: Form(
        key: _passwordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(Icons.lock_outline, 'Change Password'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: Color(0xFFD97706)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'If you received credentials from an admin, change your password here for security.',
                      style: TextStyle(
                          color: Color(0xFF92400E),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // New password
            _fieldLabel('New Password'),
            TextFormField(
              controller: _newPasswordController,
              obscureText: _obscureNew,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Enter new password';
                }
                if (v.length < 8) {
                  return 'Minimum 8 characters';
                }
                return null;
              },
              decoration: _inputDecoration(
                      '••••••••••', Icons.lock_outline)
                  .copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNew
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 20,
                    color: textGrey,
                  ),
                  onPressed: () =>
                      setState(() => _obscureNew = !_obscureNew),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Confirm password
            _fieldLabel('Confirm New Password'),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirm,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Confirm your password';
                }
                if (v != _newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              decoration: _inputDecoration(
                      '••••••••••', Icons.lock_outline)
                  .copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 20,
                    color: textGrey,
                  ),
                  onPressed: () => setState(
                      () => _obscureConfirm = !_obscureConfirm),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Strength indicators
            _passwordStrengthBar(_newPasswordController.text),
            const SizedBox(height: 24),

            // Change button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _controller.changingPassword
                    ? null
                    : _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF059669),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: _controller.changingPassword
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Change Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Password strength bar ─────────────────────────────
  Widget _passwordStrengthBar(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#\$%^&*]'))) strength++;

    final colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow.shade700,
      const Color(0xFF059669),
    ];
    final labels = ['Weak', 'Fair', 'Good', 'Strong'];

    if (password.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (i) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                height: 4,
                decoration: BoxDecoration(
                  color: i < strength
                      ? colors[strength - 1]
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        if (strength > 0) ...[
          const SizedBox(height: 6),
          Text(
            'Password strength: ${labels[strength - 1]}',
            style: TextStyle(
                fontSize: 12,
                color: colors[strength - 1],
                fontWeight: FontWeight.w600),
          ),
        ],
      ],
    );
  }

  // ── Helpers ───────────────────────────────────────────
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: primaryBlue),
        const SizedBox(width: 8),
        Text(title,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: textDark)),
      ],
    );
  }

  Widget _fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(label,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF374151))),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      prefixIcon:
          Icon(icon, color: const Color(0xFF9CA3AF), size: 20),
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: Color(0xFF0D63D1), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Widget _badge(String text, Color bg, Color color) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(
        text[0].toUpperCase() + text.substring(1),
        style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
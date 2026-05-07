import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  final auth = FirebaseAuth.instance;

  void _safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  void showError(String msg) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  // 🔐 LOGIN
  Future<void> login() async {
    _safeSetState(() => loading = true);

    try {
      final credential =
          await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = credential.user;

      if (user == null) {
        throw Exception('Login failed');
      }

      final token = await user.getIdToken(true);

      final response = await http.get(
        Uri.parse('https://api.ip.rd-crm.in/auth/me'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (!mounted) return;

      // ❌ INVALID USER
      if (response.statusCode != 200) {
        await auth.signOut();

        showError('Access denied');
        _safeSetState(() => loading = false);
        return;
      }

      // ✅ VALID USER
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful 🎉'),
          backgroundColor: Colors.green,
        ),
      );

      _safeSetState(() => loading = false);

    } catch (e) {

      await auth.signOut();

      _safeSetState(() => loading = false);

      showError(
        e.toString().replaceAll('Exception:', ''),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF6B7280),
        fontSize: 18,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 22,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color(0xFF6B7280),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color(0xFF1565D8),
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 460,
            padding: const EdgeInsets.symmetric(

  horizontal: 36,

  vertical: 40,

),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // LOGO + TITLE
                Row(
                  children: [
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1565D8),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(
                        Icons.trending_up_rounded,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),

                    const SizedBox(width: 24),

                    const Text(
                      'CareKapital',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E1B26),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                const Text(
                  'Investor Portal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1565D8),
                  ),
                ),

                const SizedBox(height: 70),

                // EMAIL
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1B26),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration(
                    'investor@example.com',
                  ),
                ),

                const SizedBox(height: 36),

                // PASSWORD
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1B26),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  onSubmitted: (_) => login(),
                  decoration: _inputDecoration(
                    '••••••••',
                  ),
                ),

                const SizedBox(height: 56),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 86,
                  child: ElevatedButton(
                    onPressed: loading ? null : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1565D8),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: loading
                        ? const SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
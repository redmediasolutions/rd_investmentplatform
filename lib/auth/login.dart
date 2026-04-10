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
  bool isLogin = true;

  final auth = FirebaseAuth.instance;

  void _safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  void showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  // 🔐 Login
  Future<void> login() async {
    _safeSetState(() => loading = true);
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await syncUser();
    } catch (e) {
      _safeSetState(() => loading = false);
      showError(e.toString());
    }
  }

  // 🆕 Register
  Future<void> register() async {
    _safeSetState(() => loading = true);
    try {
      await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await syncUser();
    } catch (e) {
      _safeSetState(() => loading = false);
      showError(e.toString());
    }
  }

  // 🔗 Call backend
  Future<void> syncUser() async {
    try {
      final user = auth.currentUser;

      if (user == null) {
        _safeSetState(() => loading = false);
        showError('User not logged in');
        return;
      }

      final token = await user.getIdToken();

      final response = await http.post(
        Uri.parse('https://api.ip.rd-crm.in/auth/sync-user'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // ⚠️ Widget may already be gone here — always guard from this point on
      if (!mounted) return;

      _safeSetState(() => loading = false);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful 🎉'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        showError('Backend sync failed (${response.statusCode})');
      }
    } catch (e) {
      _safeSetState(() => loading = false);
      showError('Something went wrong: $e');
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLogin ? 'Login' : 'Register',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: loading ? null : (isLogin ? login : register),
                child: loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(isLogin ? 'Login' : 'Register'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() => isLogin = !isLogin);
                },
                child: Text(
                  isLogin ? 'Create account' : 'Already have an account?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
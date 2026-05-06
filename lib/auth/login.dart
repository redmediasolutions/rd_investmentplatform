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
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3F2FD), Colors.white, Color(0xFFE8F5E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 380,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.1),
                )
              ],
            ),
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  // 🔷 Logo
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.green],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: const Icon(Icons.trending_up, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "InvestHub",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Manage your investments",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  // 🔘 Tabs
                  const TabBar(
                    tabs: [
                      Tab(text: "Email Login"),
                      Tab(text: "OTP Login"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      children: [
                        // =====================
                        // EMAIL LOGIN
                        // =====================
                        Column(
                          children: [
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                labelText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // 🔘 Button
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed:
                                    loading ? null : (isLogin ? login : register),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                                child: loading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(isLogin ? "Sign In" : "Register",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                        ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            TextButton(
                              onPressed: () {
                                setState(() => isLogin = !isLogin);
                              },
                              child: Text(
                                isLogin
                                    ? "Create account"
                                    : "Already have an account?",
                              ),
                            )
                          ],
                        ),

                        // =====================
                        // OTP LOGIN (UI ONLY)
                        // =====================
                        Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone_android),
                                labelText: "Mobile Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(14),
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Send OTP"),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // OTP Boxes
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                6,
                                (index) => SizedBox(
                                  width: 40,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(14),
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text("Verify OTP"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}
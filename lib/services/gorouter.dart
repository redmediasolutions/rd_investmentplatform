import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rd_investment_platform/Pages/certificates/certificates.dart';
import 'package:rd_investment_platform/Pages/dashboard/dashboard.dart';
import 'package:rd_investment_platform/Pages/investments/investment.dart';
import 'package:rd_investment_platform/Pages/investments/view_investmentbonds.dart';
import 'package:rd_investment_platform/Pages/navigation/shell.dart';
import 'package:rd_investment_platform/Pages/payouts/payouts.dart';
import 'package:rd_investment_platform/Pages/support/support.dart';
import 'package:rd_investment_platform/auth/login.dart';

GoRouter createRouter() {
  final firebaseAuth = FirebaseAuth.instance;

  return GoRouter(
    initialLocation: '/',

    // 🔁 Refresh on auth state change
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),

    // 🔐 Auth Guard
    redirect: (context, state) {
      final user = firebaseAuth.currentUser;
      final loggedIn = user != null;

      final isLogin = state.uri.path == '/login';

      // Not logged in → go to login
      if (!loggedIn && !isLogin) return '/login';

      // Logged in → prevent going back to login
      if (loggedIn && isLogin) return '/dashboard';

      return null;
    },

    routes: [
      /// 🔓 AUTH ROUTE (NO SHELL)
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),

      /// 🔒 APP ROUTES (WITH SHELL)
      ShellRoute(
        builder: (context, state, child) {
          return ShellPage(child: child);
        },
        routes: [
          // Redirect root → dashboard
          GoRoute(path: '/', redirect: (_, _) => '/dashboard'),

          GoRoute(path: '/dashboard', builder: (context, state) => Dashboard()),

          GoRoute(
            path: '/investments',
            builder: (context, state) => Investment(),
          ),

          GoRoute(
            path: '/investmentbondsview',
            builder: (context, state) =>
                ViewInvestmentbonds(investmentId: state.extra as int),
          ),

          GoRoute(
            path: '/payouts',
            builder: (context, state) => const Payouts(),
          ),

          GoRoute(
            path: '/certificates',
            builder: (context, state) => const Certificates(),
          ),

          GoRoute(
            path: '/support',
            builder: (context, state) => const Support(),
          ),
        ],
      ),
    ],
  );
}

/// 🔁 Forces GoRouter to refresh when Firebase auth changes
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

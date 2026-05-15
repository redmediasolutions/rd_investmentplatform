import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rd_investment_platform/Pages/certificates/certificates.dart';
import 'package:rd_investment_platform/Pages/dashboard/dashboard.dart';
import 'package:rd_investment_platform/Pages/investments/inverstment_model.dart';
import 'package:rd_investment_platform/Pages/investments/investment.dart';
import 'package:rd_investment_platform/Pages/investments/view_investmentbonds.dart';
import 'package:rd_investment_platform/Pages/navigation/shell.dart';
import 'package:rd_investment_platform/Pages/payouts/payouts.dart';
import 'package:rd_investment_platform/Pages/support/support.dart';
import 'package:rd_investment_platform/auth/login.dart';
import 'package:rd_investment_platform/profile/profile_page.dart';

GoRouter createRouter() {
  final firebaseAuth = FirebaseAuth.instance;

  return GoRouter(
    initialLocation: '/',

    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),

    redirect: (context, state) {
      final user = firebaseAuth.currentUser;
      final loggedIn = user != null;
      final isLogin = state.uri.path == '/login';
      if (!loggedIn && !isLogin) return '/login';
      if (loggedIn && isLogin) return '/dashboard';
      return null;
    },

    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),

      ShellRoute(
        builder: (context, state, child) {
          return ShellPage(child: child);
        },
        routes: [
          GoRoute(path: '/', redirect: (context, state) => '/dashboard'),

          GoRoute(
            path: '/dashboard',
            builder: (context, state) => DashboardScreen(),
          ),

          GoRoute(
            path: '/investments',
            builder: (context, state) => Investment(),
          ),

          GoRoute(
            path: '/investmentbondsview',
            builder: (context, state) =>
                ViewInvestmentbonds(investment: state.extra as InvestmentModel),
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

          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}

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

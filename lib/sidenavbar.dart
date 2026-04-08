import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import your theme constants
// import 'package:care_kapital_mobile_app/theme/apptheme.dart'; 

class Sidenavbar extends StatefulWidget {
  const Sidenavbar({super.key});

  @override
  State<Sidenavbar> createState() => _SidenavbarState();
}

class _SidenavbarState extends State<Sidenavbar> {
  String _selectedRoute = '/dashboard';

  Widget _item(
    BuildContext context, {
    required String route,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedRoute == route;

    return InkWell(
      onTap: () {
        setState(() => _selectedRoute = route);
        context.go(route);
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          // Active state uses a very subtle version of your primary blue
          color: isSelected
              ? const Color(0xFF0D63D1).withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? const Color(0xFF0D63D1) : const Color(0xFF6C757D),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? const Color(0xFF0D63D1) : const Color(0xFF1A1C1E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // 🛠 Fix: Increased from 10 to standard sidebar width
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- LOGO SECTION ---
          Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0D63D1), Color(0xFF00B167)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.trending_up, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Text(
                  "InvestHub",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1C1E),
                  ),
                ),
              ],
            ),
          ),

          // --- MAIN NAVIGATION ---
          _item(context, route: '/dashboard', icon: Icons.grid_view_rounded, label: "Dashboard"),
          _item(context, route: '/investments', icon: Icons.trending_up_rounded, label: "Investments"),
          _item(context, route: '/payouts', icon: Icons.account_balance_wallet_outlined, label: "Payouts"),
          _item(context, route: '/certificates', icon: Icons.description_outlined, label: "Certificates"),
          _item(context, route: '/support', icon: Icons.chat_bubble_outline_rounded, label: "Support"),

          const Spacer(),

          // --- USER PROFILE SECTION ---
          const Divider(height: 40, thickness: 1),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFF9735FF), // Purple from your theme
              child: Text("AR", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            title: const Text(
              'Arjun Reddy',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1A1C1E)),
            ),
            subtitle: const Text('arjun@email.com', style: TextStyle(fontSize: 11)),
            trailing: IconButton(
              icon: const Icon(Icons.logout, size: 20, color: Color(0xFFE53935)),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                 context.go('/login'); // Redirect to login after logout
                // Logout logic here
              },
            ),
          ),
        ],
      ),
    );
  }
}